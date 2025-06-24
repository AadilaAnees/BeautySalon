package com.salonbooking.full.controller;

import com.salonbooking.full.model.Service;
import com.salonbooking.full.model.User;
import com.salonbooking.full.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Controller
public class ServiceController {

    private final ServiceService serviceService;

    @Autowired
    public ServiceController(ServiceService serviceService) {
        this.serviceService = serviceService;
    }

    // Admin endpoints

    @GetMapping("/admin/services")
    public String adminServicesPage(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            List<Service> services = serviceService.getAllServices();
            model.addAttribute("services", services);
            return "admin/services";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load services: " + e.getMessage());
            return "admin/services";
        }
    }

    @GetMapping("/admin/service/add")
    public String addServiceForm(HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        model.addAttribute("service", new Service());
        return "admin/add-service";
    }

    @PostMapping("/admin/service/add")
    public String addService(@ModelAttribute Service service, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            serviceService.saveService(service);
            redirectAttributes.addFlashAttribute("success", "Service added successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add service: " + e.getMessage());
        }
        return "redirect:/admin/services";
    }

    @GetMapping("/admin/service/edit/{id}")
    public String editServiceForm(@PathVariable String id, HttpSession session, Model model) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            Optional<Service> service = serviceService.getServiceById(id);
            if (!service.isPresent()) {
                return "redirect:/admin/services";
            }
            model.addAttribute("service", service.get());
            return "admin/edit-service";
        } catch (IOException e) {
            return "redirect:/admin/services";
        }
    }

    @PostMapping("/admin/service/update")
    public String updateService(@ModelAttribute Service service, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            serviceService.saveService(service);
            redirectAttributes.addFlashAttribute("success", "Service updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update service: " + e.getMessage());
        }
        return "redirect:/admin/services";
    }

    @GetMapping("/admin/service/delete/{id}")
    public String deleteService(@PathVariable String id, HttpSession session, RedirectAttributes redirectAttributes) {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/login";
        }

        try {
            serviceService.deleteService(id);
            redirectAttributes.addFlashAttribute("success", "Service deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete service: " + e.getMessage());
        }
        return "redirect:/admin/services";
    }

    // Client endpoints

    @GetMapping("/client/services")
    public String clientServicesPage(HttpSession session, Model model) {
        User client = (User) session.getAttribute("user");
        if (client == null) {
            return "redirect:/login";
        }

        try {
            List<Service> services = serviceService.getAllServices();
            model.addAttribute("services", services);
            return "client/services";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load services: " + e.getMessage());
            return "client/services";
        }
    }

    // Public service listing
    @GetMapping("/services")
    public String publicServicesPage(Model model) {
        try {
            List<Service> services = serviceService.getAllServices();
            model.addAttribute("services", services);
            return "public-services";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load services: " + e.getMessage());
            return "public-services";
        }
    }

    @GetMapping("/service/{id}")
    public String serviceDetails(@PathVariable String id, Model model) {
        try {
            Optional<Service> service = serviceService.getServiceById(id);
            if (!service.isPresent()) {
                return "redirect:/services";
            }
            model.addAttribute("service", service.get());
            return "service-details";
        } catch (IOException e) {
            model.addAttribute("error", "Failed to load service details: " + e.getMessage());
            return "redirect:/services";
        }
    }
}