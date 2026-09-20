package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.TeamMember;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object quản lý bảng company_info và team_members (CMS)
 */
public class CompanyInfoDAO {

    public CompanyInfo getCompanyInfo() {
        String sql = "SELECT * FROM company_info LIMIT 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                CompanyInfo info = new CompanyInfo();
                info.setId(rs.getInt("id"));
                info.setCompanyName(rs.getString("company_name"));
                info.setSlogan(rs.getString("slogan"));
                info.setHotline(rs.getString("hotline"));
                info.setEmail(rs.getString("email"));
                info.setAddress(rs.getString("address"));
                info.setAboutSummary(rs.getString("about_summary"));
                info.setAboutDetail(rs.getString("about_detail"));
                info.setVision(rs.getString("vision"));
                info.setMission(rs.getString("mission"));
                info.setCoreValues(rs.getString("core_values"));
                info.setLogoUrl(rs.getString("logo_url"));
                info.setFacebookUrl(rs.getString("facebook_url"));
                info.setYoutubeUrl(rs.getString("youtube_url"));
                info.setWorkingHours(rs.getString("working_hours"));
                info.setUpdatedAt(rs.getTimestamp("updated_at"));
                return info;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    public boolean updateCompanyInfo(CompanyInfo info) {
        String sql = "UPDATE company_info SET company_name = ?, slogan = ?, hotline = ?, email = ?, " +
                     "address = ?, about_summary = ?, about_detail = ?, vision = ?, mission = ?, " +
                     "core_values = ?, logo_url = ?, facebook_url = ?, youtube_url = ?, working_hours = ? " +
                     "WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, info.getCompanyName());
            ps.setString(2, info.getSlogan());
            ps.setString(3, info.getHotline());
            ps.setString(4, info.getEmail());
            ps.setString(5, info.getAddress());
            ps.setString(6, info.getAboutSummary());
            ps.setString(7, info.getAboutDetail());
            ps.setString(8, info.getVision());
            ps.setString(9, info.getMission());
            ps.setString(10, info.getCoreValues());
            ps.setString(11, info.getLogoUrl());
            ps.setString(12, info.getFacebookUrl());
            ps.setString(13, info.getYoutubeUrl());
            ps.setString(14, info.getWorkingHours());
            ps.setInt(15, info.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    public List<TeamMember> getActiveTeamMembers() {
        List<TeamMember> list = new ArrayList<>();
        String sql = "SELECT * FROM team_members WHERE is_active = 1 ORDER BY sort_order ASC, id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                TeamMember m = new TeamMember(
                    rs.getInt("id"),
                    rs.getString("full_name"),
                    rs.getString("position"),
                    rs.getString("avatar_url"),
                    rs.getString("bio"),
                    rs.getString("email"),
                    rs.getInt("sort_order"),
                    rs.getBoolean("is_active")
                );
                m.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    public boolean insertTeamMember(TeamMember m) {
        String sql = "INSERT INTO team_members (full_name, position, avatar_url, bio, email, sort_order, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, m.getFullName());
            ps.setString(2, m.getPosition());
            ps.setString(3, m.getAvatarUrl());
            ps.setString(4, m.getBio());
            ps.setString(5, m.getEmail());
            ps.setInt(6, m.getSortOrder());
            ps.setBoolean(7, m.isActive());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    public boolean updateTeamMember(TeamMember m) {
        String sql = "UPDATE team_members SET full_name = ?, position = ?, avatar_url = ?, bio = ?, " +
                     "email = ?, sort_order = ?, is_active = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, m.getFullName());
            ps.setString(2, m.getPosition());
            ps.setString(3, m.getAvatarUrl());
            ps.setString(4, m.getBio());
            ps.setString(5, m.getEmail());
            ps.setInt(6, m.getSortOrder());
            ps.setBoolean(7, m.isActive());
            ps.setInt(8, m.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    public boolean deleteTeamMember(int id) {
        String sql = "DELETE FROM team_members WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }
}
