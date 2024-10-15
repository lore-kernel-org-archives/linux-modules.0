Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCC1FDFAC
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034402; cv=none; b=jm26cwJKYzPkq/r92Y/Z7pPcjPP+vbVSQ1Draa9CTytX2o1L+XZ6k/6rsUr0MPdjvn6WSVwi2VzmlpatFI2tjKG85iNAGCYdxOFeD/ok2RX5XTlXqvcnpWrPNAV9kixZY5O2SJzhz2hP4evdihC7RiU4SHPCdBtLJr5FzrMFIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034402; c=relaxed/simple;
	bh=Kp5uggGbEJrPIVkqdlvJVT6U0SCrN+hpDOmeYYUT59w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezVic9Zk4hspmGFarpyDcnBrtOy6zQ1ENJ62Je3w90IFJy8GczaNuG8anlrNzhFqGlqWcJJBCInWEpKjCvBC4reVp1MxUMxWRfv07irrsXQVOw6JE+1dP7hSXsGtHZ0alC8PG7Zikp64aD0nAV/1vdKEsB2qnD4wvKfQc53/V9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Opv7o2Sa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Opv7o2Sa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so5807827b3.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034399; x=1729639199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xasC2bG4ku4iDrf29H3XucNRhtvas+BiYTJxtPjY34w=;
        b=Opv7o2SauZsHkaEOtnSMVkRMJG96RIH4tAde9LPE+Gvy8GL8BKRr9h/3Bh2hqQUTCZ
         pJlngBMbWusiiFMy3xK+SYUffO5PF1rl0nTdkdUQ1RUtAtxRZY/UYRCc7WUusjtRf2e5
         ItIb8CEqxK6GQLQi2tOyWsfT4muWDQF60ANVTYqrZEvRk2AMGIWYp3pyTXxcpj1eSlQk
         PoqY0MlZO65norjFrQlD8ruoU7ta8RnSO9gV9F3sfe0Fai9GnkuTFfTAWIZO/DWltNZA
         ZfsZuFPhn19ujZPmQ9RxFBoULvkL5mAwz+p0nRy2LbOL34yQghKKvGvc2k9i5kMfwxTp
         /vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034399; x=1729639199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xasC2bG4ku4iDrf29H3XucNRhtvas+BiYTJxtPjY34w=;
        b=BdU+VdZH4D3KEN7C5sl34l7ts1KHCfuXQSHtT7l1qjeFgQFQocXI9Y2GyeT9u8tnVd
         j4N0Tq/RTLVnaWSokuN9bM9hRg9sPv3/H36BL1XWZeJ+IwkE24+2Bw9WcKBfP4PPreOt
         VSMKJK+Qg2xStVcj6/xhzv/D2rabCYzL4ghXjwvZ/hVnQtew6Rr7yj8w3vN1iE2SOBWx
         SKIseUsjrN27JcTzc7j1U5PSQE+I8Rqo3ApLyUtskAHygihJnpUAITo24rKNwhXxM370
         J0Izufh/2ohrcVDOYtYOQfvH5GRyuhZy0ryljxgF/pdkNB/vFK7TRUd8PbUCvfCfgDrX
         oJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS2yuPKNPvQpRTIhwGWuaY2MPiFFWGVXn/SNkDzlweVM/E6bxPuhXMfQky8W29B5aKNiYDpffGcTJCdXO6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JC00dDKFXCJIEpgs62d73Iu/1+i/0VZVeob1HxNZ/IqvYYdi
	BoavyltCN44Ti2r4sg2LuqJMM1REuSYvdNVq77cYXEb8qOeiGcvAbymog4oR/QTICalcu0JJMHU
	cP3J/vg==
X-Google-Smtp-Source: AGHT+IEhM7UuM8n6j7x3Tn2NtgtBsdUObL6hxcYJG9U32wvNR7YuZK72mjGGNuHH/96W7Ib7Lctj8rOyPY/w
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:3587:b0:68e:8de6:617c with SMTP
 id 00721157ae682-6e3d3aacfc0mr316117b3.5.1729034398638; Tue, 15 Oct 2024
 16:19:58 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:18:59 +0000
In-Reply-To: <20241015231925.3854230-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231925.3854230-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231925.3854230-5-mmaurer@google.com>
Subject: [PATCH v6 4/5] modpost: Produce extended MODVERSIONS information
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Generate both the existing modversions format and the new extended one
when running modpost. Presence of this metadata in the final .ko is
guarded by CONFIG_EXTENDED_MODVERSIONS.

We no longer generate an error on long symbols in modpost if
CONFIG_EXTENDED_MODVERSIONS is set, as they can now be appropriately
encoded in the extended section. These symbols will be skipped in the
previous encoding. An error will still be generated if
CONFIG_EXTENDED_MODVERSIONS is not set.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/Kconfig |  8 ++++++++
 scripts/mod/modpost.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 7c6588148d42..a5de2b7f2758 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -177,6 +177,14 @@ config ASM_MODVERSIONS
 	  assembly. This can be enabled only when the target architecture
 	  supports it.
 
+config EXTENDED_MODVERSIONS
+	bool "Extended Module Versioning Support"
+	depends on MODVERSIONS
+	help
+	  This enables extended MODVERSIONs support, allowing long symbol
+	  names to be versioned. The most likely reasons you would enable
+	  this are for Rust usage or aggressive LTO configurations.
+
 config MODULE_SRCVERSION_ALL
 	bool "Source checksum for all modules"
 	help
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 107393a8c48a..d18ff8a1109a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1840,15 +1840,56 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
+#ifdef CONFIG_EXTENDED_MODVERSIONS
+			/* this symbol will only be in the extended info */
+			continue;
+#else
 			error("too long symbol \"%s\" [%s.ko]\n",
 			      s->name, mod->name);
 			break;
+#endif
 		}
 		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
 	}
 
 	buf_printf(b, "};\n");
+
+	buf_printf(b, "#ifdef CONFIG_EXTENDED_MODVERSIONS\n");
+	buf_printf(b, "static const s32 ____version_ext_crcs[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_crcs\") = {\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t%#8x,\n", s->crc);
+	}
+	buf_printf(b, "};\n");
+
+	buf_printf(b, "static const char ____version_ext_names[]\n");
+	buf_printf(b, "__used __section(\"__version_ext_names\") =\n");
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
+		if (!s->module)
+			continue;
+		if (!s->crc_valid) {
+			/*
+			 * We already warned on this when producing the legacy
+			 * modversions table.
+			 * We need to skip its name too, as the indexes in
+			 * both tables need to align.
+			 */
+			continue;
+		}
+		buf_printf(b, "\t\"%s\\0\"\n", s->name);
+	}
+	buf_printf(b, ";\n");
+	buf_printf(b, "#endif\n");
 }
 
 static void add_depends(struct buffer *b, struct module *mod)
-- 
2.47.0.rc1.288.g06298d1525-goog

