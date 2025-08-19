Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44233769D
	for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605610; cv=none; b=aew3P+6+kN42yJrtaoJiqAPC08RbuBx/k0bNVull6JPwtk57xyRo62CfJ8diaztrFPuMHP/51LrlV3LF0MoHr/SKOPysnuvDIJjwOFFpged8x/50GwfJ2H+Lax3IDaZ5KEv5OyR9KaurAe68DyvXE/nUexLyivOQVp0ZNQmseTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605610; c=relaxed/simple;
	bh=dywSOFLfMogkBmbcyfNdBbCCi1K9eDNR4VWZt+BgoJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbHhgXHdWmqmwZle4fOE/ImuEXbJsfWeSOyN8eR/+/Anpc8+7jOTQq5hOnIrJEa/wxHdMONac1fr2FOCSHb1lxeTXJNSLKHJqEWIwkqD6ygis+Sx0gr1tZh4fz3EhLWLR+98oQQ4Kxh0/kS5MhgX18OiRtkGvKxj2gYaWmAGcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bMIymVUD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bMIymVUD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so2607233f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755605606; x=1756210406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uRtcEd8pcpMinDJcB3a1LhyOu4987652vqrf5zaqCM=;
        b=bMIymVUDVbiJgz/6YaA5ilZjG6Src21hq2Wu0wTcbIYMuk0ptGVzt2pzFhNtQOoJCT
         LyN4NSLHqx3wI4Y8B3949p0D+cFhKpEGld9obGLTr+CzLFecTohGDFDBK4OIVvHbNE7W
         qpvBwdx6dD86YB/+Wea7j1kVAQXKtvKzIWAqwwC5wQuZrgnGWKxbn5/6ZnUvahZio8TG
         DkidWQT5B0kmWea3mo5FrOACdWYA6PXzFTQb84AgT1Y37sFkopIxI9gWEp85tN6uZzWz
         vVVrnd0z6Z/oEzMN56lLfxV+cjgQ1uOIYgKFZHQrfLN+aNHMLFWbhlfeUha6UPkGyv3P
         NHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605606; x=1756210406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uRtcEd8pcpMinDJcB3a1LhyOu4987652vqrf5zaqCM=;
        b=gmb9w+bEWhcZ4a2QICUKX5iLfb4mb7lPtSOqt0c+Wali4rBkhVtQmj3fLLAebZBWYB
         ZQGXhiXYoxI8W6sEaw5rq3+mEAbN6SdNohhfDj5AQbNoX6Ln0zb9KJrzYQZbBUKjZ0NN
         RyY6xIu62BTxXcTL5umv1/fKfoZkPr2I3hi2roXMMoCY9ze6o/jW84+p4LY9qqHTfJ8L
         RLnVm0Cmu0nznyDqzL9LbGBXfdKtuKc3Z0KUpIHxu66MKDAohoKb3SJmLZq353Y+Zilw
         kNA8B5xv3G2dRD5bsLHrq9qn7qB/t9qsQuHQ+6kJU/s7nKREAiDoT++GCOwZlKe+rXPp
         BS8A==
X-Forwarded-Encrypted: i=1; AJvYcCUnc+zMRDis0W1K9OE0p8OU9iqfPq07s20ChNIUY/QW/cmFyMjCN3DVOrIRdWTbJzxPWh+QETiIXK4g6fvt@vger.kernel.org
X-Gm-Message-State: AOJu0YyLq7YIV2+HYfMifObi/HZXOp6E/SWJVzJWR+/TokMhdjIgf4rR
	CsoB/HplsNa5bZikX2a6akwa1/FvLWYaUB07dtWYLvJWwbTEY5Retr/qUSAcckgxvT44bQhYQHB
	uucKb
X-Gm-Gg: ASbGnctL/qenvyHzs42CnHPB2OvbxYxaVUvawZz6ZHqIp4ngNxPXOKr8Lb/KXtdxkUn
	AkUi33uS0i9AhHmoF6jKbDgzMUrulj/IvDCOgXkpSPsI8z1FsSbN9+L/jP6tPLA4XESoNU+XTTI
	lZXnd6Gdz4XpAxYw9KXVYit9sSsTWC03eiWEGAq4b5GUHfuPvIA7LG+nRooJBmO++P7cjVzmx5W
	JvtW45FHsC0Gmc0YNrm95eJcihpmSESZYWHJYXSX80xdSyLSN2EvBBIivKCp5MtmReQEBGN0qSG
	wGIvsjVUXDbg4JCFnSXxKJD/4738WDFfvAFPyL7grqb6Mf4+8zkyIEALcq4ZFIvFs5TSb8zZ3f9
	P+2prhlTKdQXLYGEI5LuxxU6lIcuIwDhJhI3IH8A=
X-Google-Smtp-Source: AGHT+IEyO17CVHXzd9F1BliU3Ul+TEXJM+jcje2z9wQ3gAvxvj+Mmq6shz2a+l3z2LEnQlSleO7Zcw==
X-Received: by 2002:a05:6000:402b:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3c0e9ff5689mr1656146f8f.25.1755605605945;
        Tue, 19 Aug 2025 05:13:25 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f6dfsm107897525ad.78.2025.08.19.05.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:13:25 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] params: Replace __modinit with __init_or_module
Date: Tue, 19 Aug 2025 14:12:09 +0200
Message-ID: <20250819121248.460105-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the custom __modinit macro from kernel/params.c and instead use the
common __init_or_module macro from include/linux/module.h. Both provide the
same functionality.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/params.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index b92d64161b75..19bb04f10372 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -595,12 +595,6 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
 }
 #endif
 
-#ifdef CONFIG_MODULES
-#define __modinit
-#else
-#define __modinit __init
-#endif
-
 #ifdef CONFIG_SYSFS
 void kernel_param_lock(struct module *mod)
 {
@@ -625,9 +619,9 @@ EXPORT_SYMBOL(kernel_param_unlock);
  * create file in sysfs.  Returns an error on out of memory.  Always cleans up
  * if there's an error.
  */
-static __modinit int add_sysfs_param(struct module_kobject *mk,
-				     const struct kernel_param *kp,
-				     const char *name)
+static __init_or_module int add_sysfs_param(struct module_kobject *mk,
+					    const struct kernel_param *kp,
+					    const char *name)
 {
 	struct module_param_attrs *new_mp;
 	struct attribute **new_attrs;
@@ -760,7 +754,8 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
+struct module_kobject * __init_or_module
+lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;

base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.50.1

