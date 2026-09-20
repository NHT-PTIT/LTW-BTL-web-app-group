package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * JavaBean ánh xạ bảng company_info (Thông tin CMS công ty)
 */
public class CompanyInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String companyName;
    private String slogan;
    private String hotline;
    private String email;
    private String address;
    private String aboutSummary;
    private String aboutDetail;
    private String vision;
    private String mission;
    private String coreValues;
    private String logoUrl;
    private String facebookUrl;
    private String youtubeUrl;
    private String workingHours;
    private Timestamp updatedAt;

    public CompanyInfo() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getSlogan() {
        return slogan;
    }

    public void setSlogan(String slogan) {
        this.slogan = slogan;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAboutSummary() {
        return aboutSummary;
    }

    public void setAboutSummary(String aboutSummary) {
        this.aboutSummary = aboutSummary;
    }

    public String getAboutDetail() {
        return aboutDetail;
    }

    public void setAboutDetail(String aboutDetail) {
        this.aboutDetail = aboutDetail;
    }

    public String getVision() {
        return vision;
    }

    public void setVision(String vision) {
        this.vision = vision;
    }

    public String getMission() {
        return mission;
    }

    public void setMission(String mission) {
        this.mission = mission;
    }

    public String getCoreValues() {
        return coreValues;
    }

    public void setCoreValues(String coreValues) {
        this.coreValues = coreValues;
    }

    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    public String getFacebookUrl() {
        return facebookUrl;
    }

    public void setFacebookUrl(String facebookUrl) {
        this.facebookUrl = facebookUrl;
    }

    public String getYoutubeUrl() {
        return youtubeUrl;
    }

    public void setYoutubeUrl(String youtubeUrl) {
        this.youtubeUrl = youtubeUrl;
    }

    public String getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(String workingHours) {
        this.workingHours = workingHours;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
