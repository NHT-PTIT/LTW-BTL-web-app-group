package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * JavaBean ánh xạ bảng team_members (Đội ngũ nhân sự công ty)
 */
public class TeamMember implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String fullName;
    private String position;
    private String avatarUrl;
    private String bio;
    private String email;
    private int sortOrder;
    private boolean isActive;
    private Timestamp createdAt;

    public TeamMember() {
    }

    public TeamMember(int id, String fullName, String position, String avatarUrl, 
                      String bio, String email, int sortOrder, boolean isActive) {
        this.id = id;
        this.fullName = fullName;
        this.position = position;
        this.avatarUrl = avatarUrl;
        this.bio = bio;
        this.email = email;
        this.sortOrder = sortOrder;
        this.isActive = isActive;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
