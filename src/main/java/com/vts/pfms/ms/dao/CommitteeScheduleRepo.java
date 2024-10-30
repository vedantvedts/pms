package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.vts.pfms.committee.model.CommitteeSchedule;

public interface CommitteeScheduleRepo extends JpaRepository<CommitteeSchedule, Long> {

}
