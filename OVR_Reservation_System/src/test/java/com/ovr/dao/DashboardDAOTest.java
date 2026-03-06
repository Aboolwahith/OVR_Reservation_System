package com.ovr.dao;

import com.ovr.model.DashboardStats;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.Map;

public class DashboardDAOTest {
    private DashboardDAO dao = new DashboardDAO();

    @Test
    void testDashboardDataFetch() {
        DashboardStats stats = dao.getcounts();
        assertNotNull(stats);
        assertTrue(stats.getTotalRooms() >= 0);
        System.out.println("Counts Verified: " + stats.getTotalRooms() + " rooms found.");
    }

    @Test
    void testMonthlyChartData() {
        Map<String, Integer> data = dao.getMonthlyReservations();
        assertNotNull(data);
        assertEquals(12, data.size(), "Should have 12 months of data");
    }
}