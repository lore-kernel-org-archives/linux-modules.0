Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5426980B
	for <linux-modules@vger.kernel.org>; Thu, 13 Mar 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876230; cv=none; b=fMDynWOBYu3zelzgEp6iQTF9EWnU7swHqOHw8QgTXMRmJNXxLXvJQp5NpsoCcq0C81twRJ0BS8+b1q+lDzE/yLdPVEIwkL8zl7XI0BIJQCtDA6PNMwBWGp3hayWrCasmN/YAfhRHqf1h0yGz5dDuzRyK35ODrO0m+ISO+GceMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876230; c=relaxed/simple;
	bh=juS07XMDjJAxWXr5mwzvAA1WxJHnGjWPahThOCqacTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+FH+WpinTSF5LVa8NymDeV5UlyI42HBqVk3VqHDuLnSJc1QwKYK5WlHoZWAmVPpMZuboCKo/aBwJEM+Ft7hgrmEVbmpJ7MAnR9cbwp3SeM/eh6r7NKlMoyQiVRH6JMT027kUYxgIjLHJVskU9M6OT+qRIu0Y/8PvlSql0y6Igc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXe5bN+z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXe5bN+z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso666467f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 13 Mar 2025 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741876226; x=1742481026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrGk+0H2Ku6XJRdKx9mhOvfZypDyUlcvla1YtjtXmlo=;
        b=IXe5bN+zLxkm7J/fSMLyukI796Fj0+3dDQajNX7kgSfLC/HUxwSMcF5RVC9Z7ijLQp
         HqcRfR5RJD0aRkL0wpBCkCxn/uKqjx8eS5SOAKQ5cGSsCIPNWDMRkSWUZhFPTAyciuow
         JhGd+TPJj2H3YqVnNcmD/3nAmI6ZWDUSCv0VG1OIV6biejsiCRkHHybttJ08wSdstjdL
         d14jhOM8VUaPVcvClVdy8G35f3bIhrvSdspXjyIldNpXxRV3qaTDLY5zOLhmSjMkkf8y
         VWySkES6HI4QVs/ZJeQo+YpeZc+C4EE3P1YUuluORVPzDk31OsrGM7tAZ51fykmLofxR
         U2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876226; x=1742481026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrGk+0H2Ku6XJRdKx9mhOvfZypDyUlcvla1YtjtXmlo=;
        b=Ydg9IjNxCM1zcUeS0VRJcW1vYi5IKg6paGogR9SLe3AnX3l2OT9ZrAtwi8poSEa11J
         RcL/dVnbYyhGvHP8JLnhpk/yWW+fj1lqy1Vrd4ieenS9Ewud35Rs5ogG4ygCPXaLSLRl
         7jKqVZgH8jEogLEJbpPbaZhHrUnt5XtsKGUz3E0KPqGM4H8t13UmHA2EA4tVPD5VMxCM
         Se4zTJlgG/CKD4MluNe6Xt+HV5gtjtWSP/JdQyYIDKRsyqnimKmzwfn7vo7NC/fRxoqx
         t2zWEl3XrEeKVFGykCZPHlTmnCFlD/gbFd5HY70nNttV5eoip/BditODxF1Zy8QsTQsC
         ba8g==
X-Forwarded-Encrypted: i=1; AJvYcCXY1q4IEyapN6af1j2bG/aOWiaaI37285yx9PMnnAkRpimZaY9azqUorse1gw+naR298pi1pszgDgUbaTo0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xIB7jMrtlXqPfHRtk5Y107YjCZtCDgJU5eUp5vggIqoDR8l6
	n9Uq1xvcwiVX1E2I32Zf2By4KzzeYGMea0FyLU/Os7WjPsZdOQ12dJLn9HXGigY=
X-Gm-Gg: ASbGncs6rOuiXG6L9FxBy/pHCQpf8ypYhtsQVEyt49rnauCW1Zy2IvLQGzmxY5rx+Ss
	1N7kjos5kFmTWIH1iy+2OJu+nXW8m5chnMKwl1CH7txfn50JxeT6l/hHfijUu12Gj7TRfKI1paX
	NTBYURWGjp1uCn7+EWfa3QZA4uqiSjeG/XCRgOczirjES8zs6okHtZmi0qEfup7xNxHhD9dKVAL
	2uhdWhZTCcRhm2OumPjBJ+g67YxjY98AohAr9CiJ2NlXM7rC6dfk6rKWu3JW/Yz2KdkuIBVXYDA
	szlNw8Vly7viIoCmFa+shNIxROwfWsVvMhdBu0q6IgPiWF/o
X-Google-Smtp-Source: AGHT+IEopD2BOlwvkpG1x6M74L7kpnMA958szdTdn2Obv0FJ9/lT9q7aHbu7ZV55PrVSeCNR56WDNg==
X-Received: by 2002:a5d:64cd:0:b0:390:f2f1:2a17 with SMTP id ffacd0b85a97d-39132da9d2amr21115722f8f.53.1741876226568;
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm2324196f8f.33.2025.03.13.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] codetag: Avoid unused alloc_tags sections/symbols
Date: Thu, 13 Mar 2025 15:29:20 +0100
Message-ID: <20250313143002.9118-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_MEM_ALLOC_PROFILING=n, vmlinux and all modules unnecessarily
contain the symbols __start_alloc_tags and __stop_alloc_tags, which define
an empty range. In the case of modules, the presence of these symbols also
forces the linker to create an empty .codetag.alloc_tags section.

Update codetag.lds.h to make the data conditional on
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/codetag.lds.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index 372c320c5043..0ea1fa678405 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_GENERIC_CODETAG_LDS_H
 #define __ASM_GENERIC_CODETAG_LDS_H
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define IF_MEM_ALLOC_PROFILING(...) __VA_ARGS__
+#else
+#define IF_MEM_ALLOC_PROFILING(...)
+#endif
+
 #define SECTION_WITH_BOUNDARIES(_name)	\
 	. = ALIGN(8);			\
 	__start_##_name = .;		\
@@ -9,7 +15,7 @@
 	__stop_##_name = .;
 
 #define CODETAG_SECTIONS()		\
-	SECTION_WITH_BOUNDARIES(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(SECTION_WITH_BOUNDARIES(alloc_tags))
 
 /*
  * Module codetags which aren't used after module unload, therefore have the
@@ -28,6 +34,6 @@
  * unload them individually once unused.
  */
 #define MOD_SEPARATE_CODETAG_SECTIONS()		\
-	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
+	IF_MEM_ALLOC_PROFILING(MOD_SEPARATE_CODETAG_SECTION(alloc_tags))
 
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.43.0

