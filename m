Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02953A6B86
	for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560098; cv=none; b=CpN8esC31f8YovwHWZMrBugLGyO89yvsh/G4yKOXybTrpJAVD80LaAVS3hR3SsBerDQwUsTUOJjgsC7XRwhKICqEM1ViqvYmQvmasfCwXaWYEGrefT5TdExDmh/9OTOX+NyfH5QG2lzAZl6wfjFg0NMMXkMb+nm38ov1Uo4xL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560098; c=relaxed/simple;
	bh=yxWFKfFkKHmuOpsxGuTO4vPY99a8JR43U1hClfLdqBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ip7phwbD9wXVJuOwX3CWo5F95kut+TO5UeKr2vu2roYBB1Kpbf4g9p1yRpETbQdADsFq8lQb9QpMkCeOmyKXQHzb83Qjb7BwKgSxIDuh47HcJpFhtjjoe9EgeoIpCIeyWowV8z6wa8PT+oSp52ZnlnYaKNstZ6Ng7cwUdp+07kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZgEaMAL; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZgEaMAL"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b934e96af9dso232803166b.3
        for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560094; x=1775164894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWI54gUN+/1z0II7jAJ2ytcdqsD5FtTzHZqzZAkbnP4=;
        b=AZgEaMALaVhgtjYEYzEr4p+GPO+hdQGklRorUAej8OyW1QByEiuxNiIzQjNmSBSCH5
         KBNvcJS86tX0zAKxocwgyzZ9H7I/cTgrmgS5QiLLCooq9H+N4pgURNw88nWozqIBbCAH
         VKsaSBESVQeJ+MegD8aJbnFrAxYGwRriCohKUEX4WxgtnF05p3rN968wYD51AzeyqFCQ
         d7/IcFyQYYlnHDpl0F5jnVWhmoFy21kJpw8YUGxJUXS4J770beaB+iZXNlHL1PKc+oaf
         az1la2pLdGkjEatIoXHOfcVnmEAzyiMJEfI2UvYACTVQGQtD5TGWvIcADsugE56Ul3E1
         Q3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560094; x=1775164894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWI54gUN+/1z0II7jAJ2ytcdqsD5FtTzHZqzZAkbnP4=;
        b=m5GC+cVEYqLSdUm9QFUEsJQJ9fwNy/hrAZnvKaR0Vjy4TPCtsL4XDaXjuWgIhQzkPG
         fJ1jDNiOZsOlEdomFWGAGgurimBSWdDoB3f7oSCWZlvRpMN5SrwUfk4jXjh73mlKtvUw
         o7YHIeAGvJLsCnIuxiuL4tn8IiGhE7J/yQf9RmngVftm0xw6A6OPIGreVrdtKd935Odw
         U9od5t8FdIQeUaY1hzxm0F01FfJXGIaOSs/kGigrES6q6aM7fydTdhUD5jlyww0qtHCl
         cxT6kLWGxCMrYZH6I+Kc6mJPwfayXULvweMfBD5upMZhCYZ0f+1fR0JskoBFfAwDMxUV
         WqMg==
X-Gm-Message-State: AOJu0Yz0Y6aHkgYhY6IbGXrcwGWJqOoCwvypU2y3S5gtfd6hQbkDicfk
	dmV2bfaqVZgrksYs6I0PuU1taHws7B7e2aRQRb0s8Uz4sV+SKmawJRWyXcD52ZeFJNa74Oo0x3R
	StZNqLfs/iQ/dK0vVKw==
X-Received: from ejcdp19.prod.google.com ([2002:a17:906:c153:b0:b94:96:8ae4])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:598e:b0:b98:7e20:b25 with SMTP id a640c23a62f3a-b9b502ed0a8mr954766b.20.1774560093907;
 Thu, 26 Mar 2026 14:21:33 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:21:29 +0000
In-Reply-To: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-1-455cd723dddf@google.com>
Subject: [PATCH v5 1/7] module: define ksym_flags enumeration to represent
 kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, gprocida@google.com
Content-Type: text/plain; charset="utf-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbol is GPL only.

The said bitset is introduced in subsequent patches and will contain
values of kernel symbol flags. These bitset will then be used to infer
flag values rather than fragmenting ksymtab for separating symbols with
different flag values, thereby eliminating the need to fragment the
ksymtab.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {

-- 
2.53.0.1018.g2bb0e51243-goog

