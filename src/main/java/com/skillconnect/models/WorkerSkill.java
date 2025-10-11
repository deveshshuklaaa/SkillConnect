package com.skillconnect.models;

public class WorkerSkill {
    private int workerId;
    private String skillName;

    // Constructors
    public WorkerSkill() {}

    public WorkerSkill(int workerId, String skillName) {
        this.workerId = workerId;
        this.skillName = skillName;
    }

    // Getters and Setters
    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }

    public String getSkillName() { return skillName; }
    public void setSkillName(String skillName) { this.skillName = skillName; }
}
