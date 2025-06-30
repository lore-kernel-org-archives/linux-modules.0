Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2328DB7D
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294179; cv=none; b=TY1vGJXvjJYMC83yvVE6topjno+330GbU0e01IdblQWvDfjJDeGv26bES+Hj/wBJ+Gcgpx5N2xxvzkeKQlp/a0LFUcv+Y4UuhK2BAx3sZzBfQyEwJq86KelwA2Ee2AKAMyxy/k/HvDj8lFggPYk6KrTKpPuKtZp3xCIIvBtt8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294179; c=relaxed/simple;
	bh=pwspzJd4AZigPvmdBQBc5YI54moVabhP2BKPyRa45tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+W4vTmvXBUPhZZvGuNtiTR/SNjOLP6tJYBwUObQ6AWIFCj4GGmEE3vsJsiM5cQDWFrqXosSMgraHzQU+DhufcNMOQrj+1/p72sEerA5Ch2PTmoz4RdD0FMPcpvHCdxvdTdTB9Wu7EuFbzku+baMBdQXYDEHK5W1p0KvImMuCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DpZRHAAG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DpZRHAAG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4537deebb01so11076425e9.0
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294174; x=1751898974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxXlGnhc5HV9WUqIY4yXx7sDZm8dL+Zm0TPRhpOl1ew=;
        b=DpZRHAAGnfQredqN11vxaA/4PuNGbgVITubbNYjwThNiu3FG470qMNrpgoZQF4IXp8
         OE9INoBnLGduDaszKG/o44CX8G6XM/chP/KfMPclx8R0r2Hh7DP6P9t/LgW8kU09Xsqk
         Nmqiebf6JfmYPuxK7iwR1ODDdmLKIoxwskkKlE7Ithjy0HJTXRmREMCEK4IYDoarGS/u
         G7Ufk91XwI+b0U2ZH/AomXXFK4a4XAV4NWej+MkJ/i2rv/n3c7Zc1WK/zg9ciLHqTm4E
         O9YjYTGX7LGUYCaotqGl6XsoK2Q+OoZBfUH7tp0Bye4k0sdroyoGFhcRw01D3/lUotOj
         CyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294174; x=1751898974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxXlGnhc5HV9WUqIY4yXx7sDZm8dL+Zm0TPRhpOl1ew=;
        b=bMA2oFC51VevQkD8HSsPQwSWdw9PTk3+6DnUmIqw3RqfHI5LIw2yi7Gu9QlCjg8hZ1
         //HaMsVRvVgfx341I26+vJ2kPkj2tv+b0vXd2hGClcPpbCz3PIv9hI5NpDVp6df1zOhH
         tk9SSJMjYH5wGWsSQDb9AhydYfTe2X5N+gisHXHNNW1VPoUt7vANJRBGvXZ1WLTdwWdg
         wedRAhkp4DoNcca3mB8D/M+5B5QTw+CaeUY9en0tpWZwSFGLMG5B3OOdijSeM5cyn2GX
         Ue2SFAh23BdZ7Cec5ItwWuxWWfU2Mr0mtW1k62kJ/xL8cEk3Eu/JAz06jYKEEMDbsJ6m
         uFcg==
X-Gm-Message-State: AOJu0Yzf1YPTz261Usu3L+7eX/Uo2No+SR9xtk4fnivm+Is7Ms3bcm6H
	p+m1C2lJrzT/ONJL+6mtlIMwSzmt00oARxA5YmZ7ccNByNqj4pz3Kf/PwZI5dRKgAuk=
X-Gm-Gg: ASbGnctfEyFIvEdwiIQOqdZGi4yap1VM32IpNlZon2TcQJT8Hr8dsDFSGMeFPLfJYHX
	1OpSQYuBNSnabec7XHD11OsVFyv9/Q/A+wTcU8bb3YMGNUwALeMoZtLFENEEGXzuKnG37j06zjz
	TnsWI9CkoYAkyb26QzweBaN0Lb01kWCfXbagBnHdf/ZfwtmCgzvfjdhRpCmefbZn/z58eQrwfsV
	kg+jWS88DgU+ttoa9SO5pa4+jRIgUJyb+VODumdsKsTjMel7mZqS/fBQPIM7Sczi+jqB3cTLDrV
	ns0m9vzW4NfeaZzoGG+p4YOb3ixK4/tfeNdnku8B+BECiXoUdNU2iVQ/CIQcWw==
X-Google-Smtp-Source: AGHT+IHN5CLUSWO1xiRD+qqKfFwkQtfevB21L0QtujyoJrVD0RIup44F3ZYXGZ/DDsSpOXdt+Yp6ew==
X-Received: by 2002:a05:6000:410f:b0:3a5:3a3b:6a3a with SMTP id ffacd0b85a97d-3a90075f95cmr8351749f8f.54.1751294174091;
        Mon, 30 Jun 2025 07:36:14 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:13 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN
Date: Mon, 30 Jun 2025 16:32:36 +0200
Message-ID: <20250630143535.267745-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630143535.267745-1-petr.pavlu@suse.com>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum module name length (MODULE_NAME_LEN) is somewhat confusingly
defined in terms of the maximum parameter prefix length
(MAX_PARAM_PREFIX_LEN), when in fact the dependency is in the opposite
direction.

This split originates from commit 730b69d22525 ("module: check kernel param
length at compile time, not runtime"). The code needed to use
MODULE_NAME_LEN in moduleparam.h, but because module.h requires
moduleparam.h, this created a circular dependency. It was resolved by
introducing MAX_PARAM_PREFIX_LEN in moduleparam.h and defining
MODULE_NAME_LEN in module.h in terms of MAX_PARAM_PREFIX_LEN.

Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN for clarity. This matches
the similar approach of defining MODULE_INFO in module.h and __MODULE_INFO
in moduleparam.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h      |  2 +-
 include/linux/moduleparam.h | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 5faa1fb1f4b4..0f1dde3996d9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -32,7 +32,7 @@
 #include <linux/percpu.h>
 #include <asm/module.h>
 
-#define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
+#define MODULE_NAME_LEN __MODULE_NAME_LEN
 
 struct modversion_info {
 	unsigned long crc;
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 110e9d09de24..a04a2bc4f51e 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -6,6 +6,13 @@
 #include <linux/stringify.h>
 #include <linux/kernel.h>
 
+/*
+ * The maximum module name length, including the NUL byte.
+ * Chosen so that structs with an unsigned long line up, specifically
+ * modversion_info.
+ */
+#define __MODULE_NAME_LEN (64 - sizeof(unsigned long))
+
 /* You can override this manually, but generally this should match the
    module name. */
 #ifdef MODULE
@@ -17,9 +24,6 @@
 #define __MODULE_INFO_PREFIX KBUILD_MODNAME "."
 #endif
 
-/* Chosen so that structs with an unsigned long line up. */
-#define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
-
 #define __MODULE_INFO(tag, name, info)					  \
 	static const char __UNIQUE_ID(name)[]				  \
 		__used __section(".modinfo") __aligned(1)		  \
@@ -284,7 +288,7 @@ struct kparam_array
 
 /* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
+	static_assert(sizeof(""prefix) - 1 <= __MODULE_NAME_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
-- 
2.49.0

