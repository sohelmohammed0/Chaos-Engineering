# Chaos Engineering – Break It to Fix It 🔥🛠️

## 🎯 Objective  
Introduce controlled failure in a system to test its **resilience** and **self-recovery mechanisms** using Chaos Engineering principles.

---

## 🛠️ Setup

- **Application**: A small microservice responding on port `3000`
- **Environment**: Local machine using Docker / simple containerized setup
- **Endpoints**:
  - `http://localhost:3000` → Returns a message: `"Hello, Chaos Engineer! System is alive."`
  - `http://localhost:3000/health` → Returns a health status: `"OK"`

---

## ⚙️ Chaos Tool

- **Tool Used**: Custom Bash script (`chaos.sh`)
- **Failure Simulated**:  
  - Container/application crash (`chaos.sh` force-stops the app)
  - Monitored recovery using `monitor.sh`

### Sample Output:
```bash
$ curl http://localhost:3000
Hello, Chaos Engineer! System is alive.

$ curl http://localhost:3000/health
OK

$ ./chaos.sh
Injecting chaos: Triggering app crash...
Checking recovery...
System recovered successfully!

$ ./monitor.sh
Starting system monitor...
System is healthy!
```

---

## 🔄 Recovery Plan

- **Monitoring Script (`monitor.sh`)**:
  - Periodically checks the health endpoint
  - Logs system status as healthy/unhealthy
- **Recovery Check**:
  - After crash, the system was able to **restart automatically**
  - **Self-healing** behavior was verified using both health and root endpoints

---

## 📋 Report (One-Pager)

| Failure Scenario     | Impact                                     | Observations & Learnings                             |
|----------------------|--------------------------------------------|------------------------------------------------------|
| App crash (manual)   | System became temporarily unavailable       | System recovered without manual intervention         |
| Health check monitor | Detected downtime, then confirmed recovery | Basic monitoring scripts help verify system behavior |

---

## 🌟 Bonus

- Automated recovery tested through a shell script
- Could be extended to use **alerts** (e.g., email, Slack) or **self-healing** tools like Kubernetes liveness probes or restart policies

---

## ✅ Conclusion

This Chaos Engineering experiment helped simulate and monitor system failures in a controlled environment. The application **recovered gracefully**, validating the resilience setup. Moving forward, improvements can include:
- Adding **alerting mechanisms**
- Using **Kubernetes probes** or **Chaos Mesh** for deeper tests
- Monitoring **CPU/network stress** with tools like `stress` or `tc`

---

> **Authored by:** *Sohel Mohammed*  
> [GitHub](https://github.com/sohelmohammed09) | DevOps Enthusiast 🚀
