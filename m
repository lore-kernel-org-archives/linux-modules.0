Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F61A4E82
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307610; cv=none; b=Zl/4QhIGnVAcxgen0YDPKIUqNr9j6XLE8vuVKKLxPht4x+r3l02TO7c03vSp37h9cZ32iO0JxGZ15W452XjMohfbQTKGoxxRQ//yPjOV9ciSS/kjpLZ1RZA29nqCFX36sP3Q1tyrbQUvnPDpGUOhxHauIOSsIVTCVye0u4VPLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307610; c=relaxed/simple;
	bh=HByXTJfGaacs4MV7ivXCvJq3lGnRepYcPD/jPTnE9OU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExCiQc2ny0hJN0mQTq/hED+gP1qXokUDVrEhT+CgHYP9/urKf5nU6xPo5uC4ky38NQLLLgjd3xZ7GAP9MDEs9gS4/VsNF2mO13YsgrplIflJXFf1Xfq0RiHi8D+t1y1yALft8hsUf8XLVk58tUyagd2XLHH2ZZvhbRGAnk2uG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SuUZMLC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SuUZMLC"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4bd76f5a8so8905587b3.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307607; x=1727912407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RglsluUoLriSL7HbUF8axxP+liCt7+SgicjK27E/sOo=;
        b=1SuUZMLCLU82vqpwJ2mBACpsNRBNdC6WVgRnSbUsvKFPxY7L7MPK+yD6KEXXfewbGy
         2IlShZajn1rcm4+Adt4FxnGW3f8lAaVwWTOvCgLyz4lO80El+dumIJ5vxIPD6tmYdPmT
         IMI3YebIeq3Y99RT7LKLtANVjjuWVoW6yoISfA7j4SPLgTKRTU9wL08lQDX9W+vKXrhG
         Db6PoovDNizNI94JlyD676F7yGDuXQY2UQvVpdGALp+JbBfwrqrSEZMrivm/JTHAtx7t
         OcWJSv3aWbGd6GN2g4L7o9O40Yc1ANrd8kOlS5e3fr9INjBgQxOPt+Z5QkgtJ8wOA5Xm
         7dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307607; x=1727912407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RglsluUoLriSL7HbUF8axxP+liCt7+SgicjK27E/sOo=;
        b=YPQ8Ck9NwmHm+SsnePfPSFL97QEY2oqW1O+oULhvZ774LR0YWb/v4bhcpQnXe97k17
         +kU/24v18j5de0+67CD2WHA0q+CLNOH0gNCycitgSuxae7XWbv4VkdOHPflppLtLsBv4
         3YkQJni1gLydbE1Zo1zwteutU9iutvQn2CqmnD8JmlwA3sOXcFEVOztog5jzlqG961hI
         R4U7Z6kxVSMUCa4kJ2hnxXu0IgFN2zhoE37KJMhPDGIjiqjIsH81YOqyuhAoruHV8oRJ
         7sT0ziHP/QtiCGj8dE6TkCd+h3ph8uTILabW+B81Vlaxl0Uhc7L9Q5XQdnPSccejAGSL
         mjIA==
X-Forwarded-Encrypted: i=1; AJvYcCWHyA1/iJ7HcZ2tlf7Zq48DtafAY9radyl8zclncQNgQHE1V0q+cBSJXTfypkNUVSvUVhYuxjsKjeGZO3ur@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvx0ENbJkQ/C5dbcM1F9gH7blvFMmAidkxu+hhgwcjlQoosKMh
	xy47jlfmYPRt1O7SRx58emSHMrpp2NwrvoPdlXnm8kFi+NAiSoxejxl6ZjOgy/0mXQw3BoNVk2c
	YQ40vSw==
X-Google-Smtp-Source: AGHT+IGASCvkEn2P1gDzoqsewJkQJHaAHK03+0AmWd/xawb1XFk5R/bQgX0n7dG9j+urvSvhJWBpQ1ZaL5iI
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:118f:b0:e24:9584:52d3 with SMTP
 id 3f1490d57ef6-e24d71625d8mr82065276.2.1727307606698; Wed, 25 Sep 2024
 16:40:06 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:30 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-16-mmaurer@google.com>
Subject: [PATCH v5 15/16] modpost: Produce extended modversion information
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Generate both the existing modversions format and the new extended one
when running modpost.

We no longer generate an error on long symbols in modpost, as they can
now be appropriately encoded in the extended section. These symbols will
be skipped in the previous encoding.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/mod/modpost.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 107393a8c48a..f8b7b793d2a2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1840,15 +1840,48 @@ static void add_versions(struct buffer *b, struct module *mod)
 			continue;
 		}
 		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
+			/* this symbol will only be in the extended info */
+			continue;
 		}
 		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
 			   s->crc, s->name);
 	}
 
 	buf_printf(b, "};\n");
+
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
 }
 
 static void add_depends(struct buffer *b, struct module *mod)
-- 
2.46.1.824.gd892dcdcdd-goog

