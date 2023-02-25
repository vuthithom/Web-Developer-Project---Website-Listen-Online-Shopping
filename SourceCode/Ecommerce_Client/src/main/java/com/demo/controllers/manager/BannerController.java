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
import com.demo.models.BannerInfo;
import com.demo.models.ImageInfo;
import com.demo.services.manager.IBannerService;
import com.demo.services.manager.IImageService;
import com.demo.services.manager.ISystemService;
import com.demo.validators.BannerValidator;

@Controller
@RequestMapping("manager/banner")
public class BannerController implements ServletContextAware {

	private ServletContext servletContext;

	@Autowired
	private BannerValidator validator;

	@Autowired
	private IBannerService bannerService;

	@Autowired
	private IImageService imageService;

	@Autowired
	private ISystemService systemService;

	@RequestMapping(value = { "index" }, method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		modelMap.put("title", "Manage banner");
		modelMap.put("bannerActive", "active");

		modelMap.put("pageTitle", "Banner list");
		modelMap.put("parentPageTitle", "Banner");

		ResponseEntity<Iterable<BannerInfo>> responseEntity = bannerService.findAllInfo();
		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			modelMap.put("banners", responseEntity.getBody());
		} else {
			modelMap.put("msg", "Server - Get all banner result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			modelMap.put("msgType", "danger");
		}
		return "manager/banner/index";
	}

	@RequestMapping(value = { "add" }, method = RequestMethod.GET)
	public String add(ModelMap modelMap) {
		BannerInfo banner = new BannerInfo();

		banner.setLink("tmp");
		banner.setCreatorId(1);
		// change after login function

		modelMap.put("title", "Add banner");
		modelMap.put("bannerActive", "active");

		modelMap.put("banner", banner);
		modelMap.put("pageTitle", "Add");
		modelMap.put("parentPageTitle", "Banner");

		return "manager/banner/add";
	}

	@RequestMapping(value = { "create" }, method = RequestMethod.POST)
	public String create(@ModelAttribute("banner") @Valid BannerInfo banner, BindingResult errors, ModelMap modelMap,
			RedirectAttributes redirectAttr) {

		validator.validate(banner, errors);
		if (errors.hasErrors()) {
			modelMap.put("title", "Add banner");
			modelMap.put("bannerActive", "active");

			modelMap.put("banner", banner);
			modelMap.put("pageTitle", "Add");
			modelMap.put("parentPageTitle", "Banner");

			return "manager/banner/add";
		} else {
			ResponseEntity<BannerInfo> responseEntity = bannerService.create(banner);
			if (responseEntity != null && responseEntity.getStatusCode() == HttpStatus.OK) {
				redirectAttr.addFlashAttribute("msg", "Add success!");
				redirectAttr.addFlashAttribute("msgType", "success");
			} else {
				redirectAttr.addFlashAttribute("msg", "Server - Create banner result "
						+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
				redirectAttr.addFlashAttribute("msgType", "danger");
			}
			return "redirect:/manager/banner/index";
		}
	}

	@RequestMapping(value = { "changePhotos/{id}" }, method = RequestMethod.GET)
	public String changePhotos(@PathVariable("id") int id, ModelMap modelMap) {
		ResponseEntity<com.demo.models.System> systemResponse = systemService.getSystem();
		com.demo.models.System system = systemResponse.getBody();

		ResponseEntity<BannerInfo> responseEntity = bannerService.findInfoById(id);
		BannerInfo banner = responseEntity.getBody();

		int imgCount = 0;
		for (@SuppressWarnings("unused") ImageInfo img : banner.getImgs()) {
			imgCount++;
		}

		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			modelMap.put("title", "Change banner photos");
			modelMap.put("bannerActive", "active");

			modelMap.put("caption", banner.getCaption());

			modelMap.put("maxFile", system.getBannerImgAmount() - imgCount);
			modelMap.put("maxFileSize", system.getMaxBannerPhotoSize());

			modelMap.put("id", banner.getId());
			modelMap.put("currentPhotos", banner.getImgs());
			modelMap.put("pageTitle", "Change photos");
			modelMap.put("parentPageTitle", "Banner");
		} else {
			modelMap.put("msg",
					"Server - Get banner result " + (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			modelMap.put("msgType", "danger");
		}
		return "manager/banner/changePhotos";
	}

	@RequestMapping(value = { "changePhotos" }, method = RequestMethod.POST)
	public String changePhotos(@RequestParam("id") int id, @RequestParam("file") MultipartFile photo,
			RedirectAttributes redirectAttr) {
		int bannerId = id;

		ResponseEntity<com.demo.models.System> systemResponse = systemService.getSystem();
		com.demo.models.System system = systemResponse.getBody();

		// updoad new img
		if (!photo.isEmpty()) {

			if (photo.getSize() / 1024 / 1024 > (system.getMaxBannerPhotoSize())) {
				redirectAttr.addFlashAttribute("msg", "Error : File is too large: " + photo.getSize() / 1024 / 1024
						+ ". Maximum file size is " + system.getMaxBannerPhotoSize());
				redirectAttr.addFlashAttribute("msgType", "danger");
			} else {
				String fileName = FileUploadHelper.upload(photo, servletContext);

				ImageInfo img = new ImageInfo();
				img.setName(fileName);
				img.setBannerId(bannerId);

				ResponseEntity<ImageInfo> responseEntity2 = imageService.create(img);

				if (responseEntity2 != null && responseEntity2.getStatusCode() == HttpStatus.OK) {
					redirectAttr.addFlashAttribute("msg", "Update photo(s) success.");
					redirectAttr.addFlashAttribute("msgType", "success");
				} else {
					redirectAttr.addFlashAttribute("msg", "Client : Create image result "
							+ (responseEntity2 == null ? "null" : responseEntity2.getStatusCode()));
					redirectAttr.addFlashAttribute("msgType", "danger");
				}
			}
		}
		return "redirect:/manager/banner/index";
	}

	@RequestMapping(value = { "edit/{id}" }, method = RequestMethod.GET)
	public String edit(@PathVariable("id") int id, ModelMap modelMap) {
		modelMap.put("title", "Edit banner");
		modelMap.put("bannerActive", "active");

		modelMap.put("pageTitle", "Edit");
		modelMap.put("parentPageTitle", "Banner");

		ResponseEntity<BannerInfo> responseEntity = bannerService.findInfoById(id);
		BannerInfo banner = responseEntity.getBody();

		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			modelMap.put("banner", banner);
		} else {
			modelMap.put("msg", "Server - Get banner by id result "
					+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
			modelMap.put("msgType", "danger");
		}
		return "manager/banner/edit";
	}

	@RequestMapping(value = { "save" }, method = RequestMethod.POST)
	public String save(@ModelAttribute("banner") @Valid BannerInfo _banner, BindingResult errors, ModelMap modelMap,
			RedirectAttributes redirectAttr) {
		int id = _banner.getId();

		validator.validate(_banner, errors);
		if (errors.hasErrors()) {
			modelMap.put("title", "Edit banner");
			modelMap.put("bannerActive", "active");

			modelMap.put("pageTitle", "Edit");
			modelMap.put("parentPageTitle", "Banner");

			return "manager/banner/edit";
		} else {
			ResponseEntity<BannerInfo> responseEntity = bannerService.findInfoById(id);
			if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
				BannerInfo banner = responseEntity.getBody();

				banner.setCaption(_banner.getCaption());
				banner.setCreated(_banner.getCreated());
				banner.setDescription(_banner.getDescription());
				banner.setCreatorId(_banner.getCreatorId());
				banner.setLink(_banner.getLink());
				banner.setStatus(_banner.isStatus());

				banner.setUpdatorId(1);
				// get current user and set updator id here, this is just for testing

				ResponseEntity<Void> responseEntity1 = bannerService.update(banner);
				if (!(responseEntity1 == null || responseEntity1.getStatusCode() != HttpStatus.OK)) {
					redirectAttr.addFlashAttribute("msg", "Update success.");
					redirectAttr.addFlashAttribute("msgType", "success");
				} else {
					redirectAttr.addFlashAttribute("msg", "Server - Update banner result "
							+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
					redirectAttr.addFlashAttribute("msgType", "danger");
				}
			} else {
				redirectAttr.addFlashAttribute("msg", "Server - Find banner by id result "
						+ (responseEntity == null ? "null" : responseEntity.getStatusCode()));
				redirectAttr.addFlashAttribute("msgType", "danger");
			}
		}

		return "redirect:/manager/banner/index";
	}

	@RequestMapping(value = { "delete/{id}" }, method = RequestMethod.GET)
	public String delete(@PathVariable("id") int id, RedirectAttributes redirectAttr) {
		ResponseEntity<Void> responseEntity = bannerService.delete(id);
		if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
			redirectAttr.addFlashAttribute("msg", "Delete success.");
			redirectAttr.addFlashAttribute("msgType", "success");
		} else {
			redirectAttr.addFlashAttribute("msg", "Server - Delete banner result " + (responseEntity == null ? "null" : responseEntity.getStatusCodeValue()));
			redirectAttr.addFlashAttribute("msgType", "danger");
		}
		return "redirect:/manager/banner/index";
	}

	@RequestMapping(value = { "deleteImage/{bannerId}/{imgId}" }, method = RequestMethod.GET)
	public String deleteImage(@PathVariable("bannerId") int bannerId, @PathVariable("imgId") int imgId, RedirectAttributes redirectAttr) {
		ResponseEntity<ImageInfo> imgResponse = imageService.findInfoById(imgId);

		if (!(imgResponse == null || imgResponse.getStatusCode() != HttpStatus.OK)) {
			try {
				// delete old image
				Path fileToDeletePath = Paths.get("src/main/webapp/uploads/images/" + imgResponse.getBody().getName());
				Files.delete(fileToDeletePath);
			} catch (Exception e) {
				redirectAttr.addFlashAttribute("msg", "Server - Delete old banner image(file) error: " + e.getMessage());
				redirectAttr.addFlashAttribute("msgType", "danger");
			}

			ResponseEntity<Void> responseEntity = imageService.delete(imgId);
			if (!(responseEntity == null || responseEntity.getStatusCode() != HttpStatus.OK)) {
				redirectAttr.addFlashAttribute("msg", "Delete success.");
				redirectAttr.addFlashAttribute("msgType", "success");
			} else {
				redirectAttr.addFlashAttribute("msg", "Server - Delete old banner image(database) result " + (responseEntity == null ? "null"
						: responseEntity.getStatusCode()));
				redirectAttr.addFlashAttribute("msgType", "danger");
			}
		} else {
			redirectAttr.addFlashAttribute("msg", "Delete image - Find image error : " + (imgResponse == null ? "null" : imgResponse.getStatusCode()));
			redirectAttr.addFlashAttribute("msgType", "danger");
		}

		return "redirect:/manager/banner/changePhotos/" + bannerId;
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}