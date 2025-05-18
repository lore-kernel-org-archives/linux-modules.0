Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC751DA3D;
	Sun, 18 May 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747563187; cv=none; b=jOem9epToRDoL0ZdbfNcl2AvdvtR1wPGVbGojgVgy47CYPwSQG6IfXKiWWV3g7Jdr8QKk1zyTRjLdSvMQfFM2LBLQuvAy3TNMJJ1l+hcxInjNTPQ9BM4zNGDihV0sEU97paPT5M/szso9mfCgDgRNqJjU9TpluA+shUvzhtnZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747563187; c=relaxed/simple;
	bh=NXp7EgDL0f5TU0KptoBP7XRodmOo3VL990R8lYNfyb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YI9Y8/g8Q844EVyv0yFcpuEU+Y2BrpDUAR3ROaN2O5ssoO9anXm8p59NVpuyaQ3h3wlJCbxJHtLG1KuPY+tyeg/G2dS3cFpgMTZkiZWx1oJkra2szMbscBznX9LA05MA4ByyEyP7Hki+ugSGnV/3OeKasZgnnUsYy76vcLL9+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TkzbssGV; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TkzbssGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=s+
	VSHine5PNrjaH5R325/+aTiBVv/4/hpNggGi1YjwA=; b=TkzbssGVcbFtd94MNj
	cAndO183Zy2wPRXKD9QNjJxZDsfSiZ0AD4RxjUqEZZxx3127lRgWujySXQeNRyzI
	dcM91GOIA68kD9OQdD9JtdzRFFNWmEQgmxImwRlowiAqEHSbNirpIXN/ZnpNy14i
	BBYFFd49GN/pDQLNilTIAkwxo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHHmF9siloIaeOCQ--.36267S4;
	Sun, 18 May 2025 18:12:26 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] module: release codetag section when module load fails
Date: Sun, 18 May 2025 18:12:12 +0800
Message-Id: <20250518101212.19930-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHHmF9siloIaeOCQ--.36267S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18Jr1fuF4xWryrWw47CFg_yoWftwc_Xw
	48X348Wr1Dtw409w4rt3Z3WrsYgry8Gr9Y9a4xtay5ta47Zw13Awnxtr9xWF1DWrZ7AFs3
	ZFnxJ3Wq9r1rCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXSdgUUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqBhRqmgpq6Y3TQACs-

When module load failed after memory for codetag sections ready,
codetag section memory was not properly released. This
causes memory leak, and if next module load happens to got the
same module address, codetag may pick the uninitialized section
when manipulating tags during module unload, and lead to
"unable to handle page fault" BUG.

Closes: https://lore.kernel.org/all/20250516131246.6244-1-00107082@163.com/
Signed-off-by: David Wang <00107082@163.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..5c6ab20240a6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2829,6 +2829,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 {
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
+	codetag_free_module_sections(mod);
 
 	free_mod_mem(mod);
 }
-- 
2.39.2

