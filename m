Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4F262D33;
	Tue, 11 Feb 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310589; cv=none; b=jSme1aJxiIoywYJRBC3QRgqVh0xftDv5oBcq5x2y/ng/Per+vRzbxiUZPCMb7vdCLSUp/XBO5A/nwfUbQwnI/uwPIPX+DXU/LOdlC7eg+zqMkNvsD+zbciBmZyyALiZT98VYZnM38Y2QzytbCghxg1QWzerWAFmOgiE9gk7E3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310589; c=relaxed/simple;
	bh=/3sXTPmHd1UID6qSXjmOeYQOJBoH0cODtgaUKrHgM/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojugiMsyfMUYck3Zn0qztGXpDww+cC2o+HSjkj4uClOFv/nFLz4Ng13Sz8eL7MCUtM1t9vcqF+1k/y1vhV+sXfTwvcsqmKuWtksTQ8rbLrQt+hu21WoNaQmygyGUEw/6bHIdG1dB7fM92KATWWLiHcE4cAGoz1e/5kzb/IWgoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcjblPVg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcjblPVg"
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id B0C012107AB4;
	Tue, 11 Feb 2025 13:49:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0C012107AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739310587;
	bh=ldM/qO0KdxfBenOA6k2tUfy02w6fasJ0fnnvLXlT6Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcjblPVgHxW9xILSvZr2YdhA30d3OxwbXIEJrvjHt+HRxg5ygyb3A3NyQJBcn2u2D
	 1tgt5IgpKsKTJy8Tehu3LKeHctWErSgyx3cQ9g60odfWJXmRW32A4o9Dk1/OLcKuqD
	 /zM1LlPugQCi2yF5Rpg0B1H0+o7lJk8iHZWgh/xQ=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: code@tyhicks.com,
	linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu,
	hch@infradead.org,
	mcgrof@kernel.org,
	frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	petr.pavlu@suse.com,
	linux@weissschuh.net,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [PATCH v3 3/4] kernel: globalize lookup_or_create_module_kobject()
Date: Tue, 11 Feb 2025 13:48:41 -0800
Message-Id: <20250211214842.1806521-4-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_or_create_module_kobject() is marked as static and __init,
to make it global drop static keyword.
Since this function can be called from non-init code, use __modinit
instead of __init, __modinit marker will make it __init if
CONFIG_MODULES is not defined.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 include/linux/module.h | 2 ++
 kernel/params.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 12f8a7d4fc1c..aeaaf9e068eb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -162,6 +162,8 @@ extern void cleanup_module(void);
 #define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
+struct module_kobject *lookup_or_create_module_kobject(const char *name);
+
 /* Generic info of form tag = "info" */
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
 
diff --git a/kernel/params.c b/kernel/params.c
index 6e87aef876b2..1073f8ebd5a6 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -763,7 +763,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
+struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
-- 
2.34.1

