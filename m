Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105696;
	b=N3yqXYCjbur6hpIJPntW2NzIub02rtX/EBHWwWfnYyohr9ca28JrsYJU8prjusPdAhrM
	 ZM9rDMeLPn+dpiq1HzeQrvtsUjLt43cAqS5+X5TJdYxcL/Dv/TwNjWyOOpSI1WUkWSJYo
	 RWkykivwSxCZZD/zGqWQiamJVKks6jeWybP3ObO0pazqVXsvk4B1J1hka4sq4nbMx6TwD
	 K0jb0Ksze6P0Q14/grlGxwKMQfd1/E/t6crci5YSHOZrkUSq0zhYVNshXVov8mBQw1j+A
	 MwKZ4sFvH9xqKJ+8a8cG7x3qDa5bE1xTzqBYFPzCnjXt4QkPbYr3JRhrujAi2UTY5Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Change-ID:Content-Transfer-Encoding;
	bh=mQjH/1G4I2QwMYT8EjQm95PJnpRkq5Bw5wDBEf2M6gs=;
	b=ydfbEUfRd8pysWLFfTbsD8593SvG253E+nL7USd8PXqw9W4bHbR94axDTU+AI+Aicdfd
	 /8+yVpN2lk72eyNmwhd8Y8DroP8TB4RPaA9Ti3HPlI+3/Enu7mWNNHEwrVsbz8+yZ/H1K
	 mTDERy2X18De9ZHWOR71/NoOx8Qo4iTjQx5lr1C8EpGhXkvWHt0HNQVdp1LzKQbgY0KhP
	 M2FMuI8ObOu8bxgVlcv9lg+1jenSmERqgkJgk5XLLU6EGJrmtkokXchNXHb/NP+DqPvQz
	 dhwCo5jav5+/Xzu0YUBQ3ojthLEBo8ratSdextdn4UeWHfSCI5iHFiEWZ+O8YSU2mbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KETQ+bcA;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A876D606A320
	for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 16:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A876D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KETQ+bcA
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb606491faso14284895e9.3
        for <linux-modules@vger.kernel.org>; Thu, 19 Nov 2026 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795105694; x=1795710494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQjH/1G4I2QwMYT8EjQm95PJnpRkq5Bw5wDBEf2M6gs=;
        b=KETQ+bcA1guKwDzrwmnjdPYgIwWZQFupivcig1XavGM87YjM78N6Hj0b1NZLaiDI6I
         vpMPG/FPvFXJqVz1C/OONnlvlBmxqAlyoe7II82tJEAkTHVqf3W1+azsapd0vX4y3C4x
         +f571XihvNR1v1UMfoeYV1UwJVC54C+xQ4UFZBuOftTPYf20kDfs9xPgQXLptxVvUGgk
         +V/K4jZ1UjuuvjcK+OkLgILtcE9MsKCw+FIeffwouWKEPNWGyp+grGxfEDlvtLMJpiii
         pX8v2EWW61/S3Wr53UBc/428QPVGqmcUtpOEc8tI6ndUZzvGmHrw6HGj4ZODZNI8H62e
         5W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795105694; x=1795710494;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mQjH/1G4I2QwMYT8EjQm95PJnpRkq5Bw5wDBEf2M6gs=;
        b=ufh4/3W0sxx4cQthhtyw+yjVAqWOK4QR03PX0xJ3NR2f4u180XzNGGsRaI6MhMbXk8
         uJAQBJ3WZOwjjfTjOoEishHTT2PiqqwckaR6/JToYsjZp6VrCgy9Jq0Y4nHmbvHqWVe3
         fTkCyBXVTJmrKCj584rR26l+AXbRlrG9KHeFucWPM/p/EzfUrMQD6V1sqrzW4Ir30yW5
         x4lQh9LSuBF1dNwG+St7LcZfHx5DhPBaL/9iQFXESZ1mQ8VXgNXeKEW9j4+/vX2btr3a
         ms6gXNuMSbZpEnXTI3Rq7yRUV692KsnZE15+2LB17WBMndBtyHyt5p3ULP1/Ic8Ril4l
         xJeQ==
X-Forwarded-Encrypted: i=1; AL+hErHe3YyqhmBzAM1asMiP2xrsIL+XAvdKBomPdlGFgGFRgpYmvUL4yexavgv8BhN1CbmG84Y76Y/rHPPf+IPk@vger.kernel.org
X-Gm-Message-State: APuU4Z8UXnF7zOmWY2FwXQqT0ksyII3Z+DHL6kk0mOtyy0RrIcTtQQSR
	mioo7yB9jbvHeUF9jRChfKuq1Ayic3ZMwBtqUiTGm1+77hxshYKDBaUC7Jxfu0ishqo=
X-Gm-Gg: AYBFou3yCPmj7ijPPo2m6s1pY90+R2zCnDX37gCBTlG9PLe3R+EebBW/mEK6bkSv90G
	qe4mLtAJQzV+WH2vYxyHEG3wcRIJNxw5QRNQlejDHmyXrvd3pjGdDl6UOHolre2WLvlDJvLYYxj
	cby9s6mOytAslvvCkdpV+4sjqdpnXs4Fcj5fdCVu60wwdAYVh9jHR29zUuqxzSoMkSyRq8jABP0
	+/RB85/jtyIYAufGORosUb1I0gEliHEq6lgLA9kDA7+vXhgyQnyRxrnCk4pEZDg8mLUC/3KrqZ7
	opvkkSBXyEGPjgXktVJI6tEZT93iQt/EgarrtzhbV0Ezubv0sRB/OgZLVqtLMouLN+MiG3QE07m
	/iNJbY6QIOnE4Y8bamsEna8WhtPg+hbZVjHkLqdgDKGrjQw4AP8mN2vNjjA6ec52gYhUCSJ5+y3
	29Ymt3a2rwhzKAf5fFjXSrpMMHbnG7irYlnNtCd0A5KodeH7FSMn2z7MgaW9l5EbvK4hPTllTm+
	LYTHpUf9bRwakAZLI1oIABenCC5po2b6Va69LW10pnptgbDk20fbT3t10h5t/chZWfxyqLOy4Rf
	b0cvBiox2xRa69EK6dp4HxQR
X-Received: by 2002:a05:600c:1548:b0:4bb:7347:d5df with SMTP id 5b1f17b1804b1-4bb88814405mr268485e9.13.1795105693739;
        Thu, 19 Nov 2026 08:28:13 -0800 (PST)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm75275965e9.4.2026.11.19.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:28:13 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Clarify purpose and description of elf_validity_cache_copy()
Date: Thu, 19 Nov 2026 17:25:27 +0100
Message-ID: <20261119-module-elf-validation-v1-1-69a74a84552c@suse.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261119-module-elf-validation-a5a0e28e6dcb
Content-Transfer-Encoding: 8bit

With the advent of LLM agents, a number of recent patches and bug reports
for the module loader focus on its validation of module ELF metadata.
However, many of them are misguided.

Loading a module is a privileged operation. The ELF metadata can normally
be trusted, just as the module code itself is expected to be correct. The
checks in elf_validity_cache_copy() are intended to catch accidental
corruption and basic violations of the ELF format, rather than to provide
exhaustive validation. The only requirement is that enough of the ELF data
is validated for the module loader to safely reach the blacklist check
without crashing on a corrupted module file. This allows a broken module to
be blacklisted and prevented from loading.

Clarify the purpose of elf_validity_cache_copy() and otherwise clean up its
description. Hopefully, LLM agents will take this into account and the
number of validation-related reports will decrease.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..0c204f07ca68 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2421,24 +2421,33 @@ static int elf_validity_cache_strtab(struct load_info *info)
 }
 
 /*
- * Check userspace passed ELF module against our expectations, and cache
- * useful variables for further processing as we go.
+ * Check the ELF module passed in from userspace against our expectations, and
+ * cache useful variables for further processing as we go.
  *
- * This does basic validity checks against section offsets and sizes, the
- * section name string table, and the indices used for it (sh_name).
+ * Loading a module is a privileged operation. The ELF metadata can normally be
+ * trusted, just as the module code itself is expected to be correct. These
+ * checks are intended to catch accidental corruption and basic violations of
+ * the ELF format, rather than to provide exhaustive validation. The only
+ * requirement is that enough of the ELF data is validated for the module loader
+ * to safely reach the blacklist check without crashing on a corrupted module
+ * file. This allows a broken module to be blacklisted and prevented from
+ * loading.
  *
- * As a last step, since we're already checking the ELF sections we cache
- * useful variables which will be used later for our convenience:
+ * The checks cover the ELF header, section offsets and sizes, section-name and
+ * symbol string tables, offsets into those tables, and selected
+ * section-specific constraints.
  *
- * 	o pointers to section headers
- * 	o cache the modinfo symbol section
- * 	o cache the string symbol section
- * 	o cache the module section
+ * While validating, cache the following for later use:
  *
- * As a last step we set info->mod to the temporary copy of the module in
- * info->hdr. The final one will be allocated in move_module(). Any
- * modifications we make to our copy of the module will be carried over
- * to the final minted module.
+ * * pointers to the section headers and section-name string table
+ * * indices of relevant sections, including .modinfo, the symbol table, the
+ *   symbol string table, the module section, and version sections
+ * * a pointer to the symbol string table
+ *
+ * Finally, set info->mod to point to the temporary module struct within
+ * info->hdr. The final copy of the module struct will be allocated in
+ * move_module(). Any modifications to the temporary copy will be carried over
+ * to the final one.
  */
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261119-module-elf-validation-a5a0e28e6dcb
