package com.demo.controllers.manager;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.helpers.FileUploadHelper;
import com.demo.models.BranchInfo;
import com.demo.models.CategoryInfo;
import com.demo.models.ProductInfo;
import com.demo.models.StoreInfo;
import com.demo.services.manager.IBranchService;
import com.demo.services.manager.ICategoryService;
import com.demo.services.manager.IProductService;
import com.demo.services.manager.IStoreService;
import com.demo.services.manager.ISystemService;

@Controller
@RequestMapping(value = { "manager/product" })
public class ProductController implements ServletContextAware {

	private ServletContext servletContext;

	@Autowired
	private IProductService productService;

	@Autowired
	private ISystemService systemService;

	@Autowired
	private IStoreService storeService;

	@Autowired
	private ICategoryService categoryService;

	@Autowired
	private IBranchService branchService;

	@RequestMapping(value = { "index" }, method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		modelMap.put("title", "Manage product");
		modelMap.put("productActive", "active");

		modelMap.put("pageTitle", "Product list");
		modelMap.put("parentPageTitle", "Product");

		ResponseEntity<Iterable<ProductInfo>> responseEntity = productService.findAllInfo();
		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			modelMap.put("items", responseEntity.getBody());
		} else {
			modelMap.put("msg", "Server - Get all product result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			modelMap.put("msgType", "danger");
		}
		return "manager/product/index";
	}

	@RequestMapping(value = { "edit/{id}" }, method = RequestMethod.GET)
	public String edit(@PathVariable("id") int id, ModelMap modelMap) {
		modelMap.put("title", "Edit product");
		modelMap.put("productActive", "active");

		modelMap.put("pageTitle", "Edit");
		modelMap.put("parentPageTitle", "Product");

		ResponseEntity<ProductInfo> responseEntity = productService.findInfoById(id);
		ProductInfo result = responseEntity.getBody();

		ResponseEntity<Iterable<StoreInfo>> storeRespone = storeService.findAllInfo();
		ResponseEntity<Iterable<CategoryInfo>> categoryRespone = categoryService.findAllInfo();
		ResponseEntity<Iterable<BranchInfo>> branchRespone = branchService.findAllInfo();

		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			if (!(storeRespone == null || storeRespone.getStatusCode() != HttpStatus.OK)) {
				if (!(categoryRespone == null || categoryRespone.getStatusCode() != HttpStatus.OK)) {
					if (!(branchRespone == null || branchRespone.getStatusCode() != HttpStatus.OK)) {
						modelMap.put("stores", storeRespone.getBody());
						modelMap.put("categories", categoryRespone.getBody());
						modelMap.put("branches", branchRespone.getBody());

						modelMap.put("img", result.getAvatar());
						modelMap.put("item", result);
					} else {
						modelMap.put("msg", "Server - Get branches result "
								+ (branchRespone == null ? "null" : branchRespone.getStatusCode()));
						modelMap.put("msgType", "danger");
					}
				} else {
					modelMap.put("msg", "Server - Get categories result "
							+ (categoryRespone == null ? "null" : categoryRespone.getStatusCode()));
					modelMap.put("msgType", "danger");
				}
			} else {
				modelMap.put("msg",
						"Server - Get stores result " + (storeRespone == null ? "null" : storeRespone.getStatusCode()));
				modelMap.put("msgType", "danger");
			}
		} else {
			modelMap.put("msg", "Server - Get product by id result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			modelMap.put("msgType", "danger");
		}

		return "manager/product/edit";
	}

	@RequestMapping(value = { "save" }, method = RequestMethod.POST)
	public String save(@ModelAttribute("item") @Valid ProductInfo item, BindingResult errors,
			@RequestParam(name = "newAvatar", required = false) MultipartFile newAvatar, ModelMap modelMap,
			RedirectAttributes redirectAttr) {
		ResponseEntity<com.demo.models.System> systemResponse = systemService.getSystem();
		com.demo.models.System system = systemResponse.getBody();

		if (errors.hasErrors()) {
			ResponseEntity<Iterable<StoreInfo>> storeRespone = storeService.findAllInfo();
			ResponseEntity<Iterable<CategoryInfo>> categoryRespone = categoryService.findAllInfo();
			ResponseEntity<Iterable<BranchInfo>> branchRespone = branchService.findAllInfo();

			if (!(storeRespone == null || storeRespone.getStatusCode() != HttpStatus.OK)) {
				if (!(categoryRespone == null || categoryRespone.getStatusCode() != HttpStatus.OK)) {
					if (!(branchRespone == null || branchRespone.getStatusCode() != HttpStatus.OK)) {
						modelMap.put("stores", storeRespone.getBody());
						modelMap.put("categories", categoryRespone.getBody());
						modelMap.put("branches", branchRespone.getBody());

						modelMap.put("title", "Edit product");
						modelMap.put("productActive", "active");

						modelMap.put("img", item.getAvatar());

						modelMap.put("pageTitle", "Edit");
						modelMap.put("parentPageTitle", "Product");
					} else {
						modelMap.put("msg", "Server - Get branches result "
								+ (branchRespone == null ? "null" : branchRespone.getStatusCode()));
						modelMap.put("msgType", "danger");
					}
				} else {
					modelMap.put("msg", "Server - Get categories result "
							+ (categoryRespone == null ? "null" : categoryRespone.getStatusCode()));
					modelMap.put("msgType", "danger");
				}
			} else {
				modelMap.put("msg",
						"Server - Get stores result " + (storeRespone == null ? "null" : storeRespone.getStatusCode()));
				modelMap.put("msgType", "danger");
			}

			return "manager/product/edit";
		} else {
			// upload new avatar
			if (!newAvatar.isEmpty()) {
				if (newAvatar.getSize() / 1024 / 1024 > system.getMaxBannerPhotoSize()) {
					redirectAttr.addFlashAttribute("msg", "File is too large: " + (newAvatar.getSize() / 1024 / 1024)
							+ ". Maximum file size is: " + system.getMaxBannerPhotoSize());
					redirectAttr.addFlashAttribute("msgType", "danger");
				} else {
					try {
						String fileName = FileUploadHelper.upload(newAvatar, servletContext);
						
						// delete old image
						Path fileToDeletePath = Paths.get("src/main/webapp/uploads/images/" + item.getAvatar());
						Files.delete(fileToDeletePath);
						
						item.setAvatar(fileName);
					} catch (Exception e) {
						redirectAttr.addFlashAttribute("msg", "Delete old product's avatar error: " + e.getMessage());
						redirectAttr.addFlashAttribute("msgType", "danger");
					}
				}
			}

			ResponseEntity<Void> responseEntity = productService.update(item);
			if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {
				redirectAttr.addFlashAttribute("msg", "Update success!");
				redirectAttr.addFlashAttribute("msgType", "success");
			} else {
				redirectAttr.addFlashAttribute("msg", "Server - Update product result "
						+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
				redirectAttr.addFlashAttribute("msgType", "danger");
			}

			return "redirect:/manager/product/index";
		}
	}

	@RequestMapping(value = { "add" }, method = RequestMethod.GET)
	public String add(ModelMap modelMap) {
		modelMap.put("title", "Add product");
		modelMap.put("productActive", "active");

		modelMap.put("pageTitle", "Add");
		modelMap.put("parentPageTitle", "Product");

		ProductInfo result = new ProductInfo();
		
		result.setBranchId(1);
		result.setIsNewProduct(true);
		result.setSaleOffPercent(0);
		result.setStoreId(1);
		result.setStatus(true);
		
		ResponseEntity<Iterable<CategoryInfo>> categoryRespone = categoryService.findAllInfo();
		ResponseEntity<Iterable<BranchInfo>> branchRespone = branchService.findAllInfo();

		if (!(categoryRespone == null || categoryRespone.getStatusCode() != HttpStatus.OK)) {
			if (!(branchRespone == null || branchRespone.getStatusCode() != HttpStatus.OK)) {
				modelMap.put("categories", categoryRespone.getBody());
				modelMap.put("branches", branchRespone.getBody());

				modelMap.put("item", result);
			} else {
				modelMap.put("msg", "Server - Get branches result "
						+ (branchRespone == null ? "null" : branchRespone.getStatusCode()));
				modelMap.put("msgType", "danger");
			}
		} else {
			modelMap.put("msg", "Server - Get categories result "
					+ (categoryRespone == null ? "null" : categoryRespone.getStatusCode()));
			modelMap.put("msgType", "danger");
		}

		return "manager/product/add";
	}

	@RequestMapping(value = { "create" }, method = RequestMethod.POST)
	public String add(@ModelAttribute("item") @Valid ProductInfo item, BindingResult errors,
			@RequestParam(name = "newAvatar", required = false) MultipartFile newAvatar, ModelMap modelMap,
			RedirectAttributes redirectAttr) {
		ResponseEntity<com.demo.models.System> systemResponse = systemService.getSystem();
		com.demo.models.System system = systemResponse.getBody();

		if (errors.hasErrors()) {
			ResponseEntity<Iterable<CategoryInfo>> categoryRespone = categoryService.findAllInfo();
			ResponseEntity<Iterable<BranchInfo>> branchRespone = branchService.findAllInfo();

				if (!(categoryRespone == null || categoryRespone.getStatusCode() != HttpStatus.OK)) {
					if (!(branchRespone == null || branchRespone.getStatusCode() != HttpStatus.OK)) {
						modelMap.put("categories", categoryRespone.getBody());
						modelMap.put("branches", branchRespone.getBody());

						modelMap.put("title", "Add product");
						modelMap.put("productActive", "active");

						modelMap.put("pageTitle", "Add");
						modelMap.put("parentPageTitle", "Product");
					} else {
						modelMap.put("msg", "Server - Get branches result "
								+ (branchRespone == null ? "null" : branchRespone.getStatusCode()));
						modelMap.put("msgType", "danger");
					}
				} else {
					modelMap.put("msg", "Server - Get categories result "
							+ (categoryRespone == null ? "null" : categoryRespone.getStatusCode()));
					modelMap.put("msgType", "danger");
				}

			return "manager/product/add";
		} else {
			// upload new avatar
			if (!newAvatar.isEmpty()) {
				if (newAvatar.getSize() / 1024 / 1024 > system.getMaxBannerPhotoSize()) {
					redirectAttr.addFlashAttribute("msg", "File is too large: " + (newAvatar.getSize() / 1024 / 1024)
							+ ". Maximum file size is: " + system.getMaxBannerPhotoSize());
					redirectAttr.addFlashAttribute("msgType", "danger");
					
					return "redirect:/manager/product/index";
				} else {
					String fileName = FileUploadHelper.upload(newAvatar, servletContext);
					item.setAvatar(fileName);
				}
			} else {
				item.setAvatar("defaultPreviewImg.png");
			}

			ResponseEntity<ProductInfo> responseEntity = productService.create(item);
			if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {
				redirectAttr.addFlashAttribute("msg", "Create product success!");
				redirectAttr.addFlashAttribute("msgType", "success");
			} else {
				redirectAttr.addFlashAttribute("msg", "Server - Create product result "
						+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
				redirectAttr.addFlashAttribute("msgType", "danger");
			}

			return "redirect:/manager/product/index";
		}
	}

	@RequestMapping(value = { "lock/{id}" }, method = RequestMethod.GET)
	public String lock(@PathVariable("id") int id, ModelMap modelMap) {
		ResponseEntity<ProductInfo> responseEntity = productService.findInfoById(id);

		ProductInfo result = responseEntity.getBody();

		if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {
			modelMap.put("title", "Lock product");
			modelMap.put("productActive", "active");

			modelMap.put("id", result.getId());
			modelMap.put("productName", result.getName());
			modelMap.put("pageTitle", "Lock");
			modelMap.put("parentPageTitle", "Product");
		} else {
			System.out.println("Client - Update get product result" + responseEntity == null ? "null"
					: responseEntity.getStatusCode());
		}
		return "manager/product/lock";
	}

	@RequestMapping(value = { "lock" }, method = RequestMethod.POST)
	public String lock(@RequestParam("banReason") String banReason, @RequestParam("id") int id) {

		ResponseEntity<Void> responseEntity = productService.toggleStatus(id);
		if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {
			responseEntity = productService.updateBanReason(id, banReason);

			if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {

			} else {
				System.out.println("Client - Update lock product(ban reason) result" + responseEntity == null ? "null"
						: responseEntity.getStatusCode());
			}
		} else {
			System.out.println("Client - Update lock product(status) result" + responseEntity == null ? "null"
					: responseEntity.getStatusCode());
		}
		return "redirect:/manager/product/index";
	}

	@RequestMapping(value = { "delete/{id}" }, method = RequestMethod.GET)
	public String delete(@PathVariable("id") int id, RedirectAttributes redirectAttr) {
		ResponseEntity<Void> responseEntity = productService.delete(id);
		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			redirectAttr.addFlashAttribute("msg", "Delete success!");
			redirectAttr.addFlashAttribute("msgType", "success");
		} else {
			redirectAttr.addFlashAttribute("msg", "Server - Delete product result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			redirectAttr.addFlashAttribute("msgType", "danger");
		}
		return "redirect:/manager/product/index";
	}

	@RequestMapping(value = { "toggleStatus/{id}" }, method = RequestMethod.GET)
	public String toggleStatus(@PathVariable("id") int id, RedirectAttributes redirectAttr) {
		ResponseEntity<Void> responseEntity = productService.toggleStatus(id);
		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {

		} else {
			redirectAttr.addFlashAttribute("msg", "Server - Toggle product status result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			redirectAttr.addFlashAttribute("msgType", "danger");
		}
		return "redirect:/manager/product/index";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}