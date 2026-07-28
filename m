Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EC3A4508
	for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260006; cv=none; b=iZwvjL+kuPLFrfQ0m4XJH/aVJ6prt6cgQHR341GcrhUon6K4qecdIWO07N9KvJdggxMwE3ZWDQslum+rON+L3lYF1u0OCgyNggj24ePkTuOuRIaUvdDQs/aHfIl3AbSVCPeQD6//onFsiRkc6zPHR+ae/AeUI/QsUNZUyA40kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260006; c=relaxed/simple;
	bh=PdUOJu99HkI5PeygkebEZNSzMyeA4frwgEEHVNgJeJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naZ6zQ/IDRFR8DatmBBN0mSoA+PyQjCy2II3TYPhYqbRhpTuPH3b02kZEw/jYlj0LlBikj0SJsGTNUDSbLEGY2HevNEDBy31oOuWkvmDTZenrh301VM5z3kYJTXSS8uAq6AFb8h2dxDMiUne81nKN2guIfeMNdVIXL5QEXRAvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6U5PQu8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6U5PQu8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so1591125ad.2
        for <linux-modules@vger.kernel.org>; Tue, 28 Jul 2026 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785260005; x=1785864805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb0WF0n1RxlJGwkmjohF8baQfdZt5q+eDoAvueXnK6s=;
        b=U6U5PQu8gpdu9pILXDAq+yCrt0pgtenvlY1aE7FDBqE0vmC9KjiNV/wO6bQmZ9fNWG
         y5XnlGBBFD1+a/kxB+/DS7LixNq+9TFfl+tDlU6AypcVP41qMK1O/Rf5WjNhtTCqumDc
         eEQq7hCGmXpzcJhsjCQxiwAgU1HHMlGk++jV/P2JCGXDvrXm+Badh1I6iYfDyvwz/1wT
         etlMzmKhS3vIShxrkMNV2GNVLop6JuUBfFTg+WgNs3M9I8DLGyz3EwQhLSTufJUVI4Xh
         vXWk/uo9BsXoYcrFyyHqLgu3s4siWWdbvrr6lNIets3MHfXcaFywMJGnF6TLjD+EC1Dg
         Farg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785260005; x=1785864805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rb0WF0n1RxlJGwkmjohF8baQfdZt5q+eDoAvueXnK6s=;
        b=jS5EYn30MY1FosWaY2v1+lZWziyvnYNjEfYbsQXLq7j5O3KFcRpV0Pj/41TDH9kW2J
         xaiesvG9ITa9PW6C1I8dEmD0GLSBHKf2QiAqKgFOpwwXzP8m4RxWYFEHgYT03n/CJO5a
         bTz4OKG2NAheKddV5iHWkmdl/hppqBaJpYXX6G+HpAnFJJlijUuZ84uYKmbSaDKAeOCH
         mnD90yYvGYlJkxqE0XMQAXwRHo/jL0BsdqSMbNYTWgvh36srZhN0BAyhldDLAzceTZcn
         9lCy5Z8KbV/rnoghnYdHB9SDfLt6f9L/iVlQEKpLrIdir8VBrIeGNmazAe7shDJJkc57
         FYEA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/vlShMsuuZ+AqFgdFfYafhsxAwhoO8TGOYxGyI+bIwhcCsxWm1Q5CM5M+SpEO8b1Vd+dA9cTyj+DMTzwL@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwr+4b3WTaEZsbsdn0gO1o63J9UdCYl1omkmEE0LqkCLEJ2Bi
	42RVOghQYN2qpRn2k0mRFnXwa0cmH+zaepeW7ZpQFLlv3SvQ0gSnuU8X
X-Gm-Gg: AR+sD13dgscIc1RzWS3nnhJQoug/zNuZsrC60PfFJZSA1OvHODB3hS+S96JD4WVAiwv
	VNSahJSxLfEXmWAMf4cGUiq21/86ANNQ/kuSxIvxg2Cm4aarKW/M4f46MM38VucbwlItA2KyaIS
	yuWue20vzgmUyYzpiq2giOwFCcfdrUXo/2JNbD+16Qd8S3eCC9D0AKDXovDgWaVrvvSKBIucFsn
	a6gkddlrBT45Jzr9FjPC99wmwuA9pWQdqUe2X4wpFhe+04gcEUPejuvPCsFgC/lWxVhRVBctCyN
	9MKXBL3x3PbKzmP1+APn5CwPIIMOBJpvTFzgpGqbC4ZCsTxuzMYzcOenV9fZPGlOWo6fXR4cp92
	+6GParMTue6sxklT4wBYbTySJFwaff77ypwk38lFjCWuO0uTkFZWExh4Et0f38VlFcUCIBf4EVm
	2c/+dtXa4X+RZCEoB2RapufkLxCVph6JpW4zkkQ4cv1cFEE60gUBvYmP6MDLOhe70B8E+PiDBKI
	roAMyhK2Fd9/vwLRBVIv+mPuveWvZr9yF4o
X-Received: by 2002:a17:903:2281:b0:2c9:b8b7:5d1c with SMTP id d9443c01a7336-2d015b0a013mr38436345ad.16.1785260004859;
        Tue, 28 Jul 2026 10:33:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:e192:4a0c:2079:ffb7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504bb29b2sm802360eec.13.2026.07.28.10.33.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:33:24 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: samitolvanen@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org
Cc: atomlin@atomlin.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: reject malformed .modinfo sections
Date: Tue, 28 Jul 2026 23:18:18 +0545
Message-ID: <20260728173318.63736-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_modinfo() and module_next_tag_pair() parse .modinfo as a sequence of NUL-terminated tag=value strings. elf_validity_cache_index_info() caches the .modinfo section index and immediately calls get_modinfo() to find the module name for early error reporting, but it does not verify that the section is non-empty or NUL-terminated first.

A malformed module can therefore make the loader read past the end of .modinfo while searching for a tag.

Reject empty .modinfo sections and sections that are not NUL-terminated before parsing them.

Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 kernel/module/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a..7450319f9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2083,6 +2083,8 @@ static int elf_validity_cache_secstrings(struct load_info *info)
 static int elf_validity_cache_index_info(struct load_info *info)
 {
 	int info_idx;
+	Elf_Shdr *info_shdr;
+	char *modinfo;
 
 	info_idx = find_any_unique_sec(info, ".modinfo");
 
@@ -2096,6 +2098,18 @@ static int elf_validity_cache_index_info(struct load_info *info)
 	}
 
 	info->index.info = info_idx;
+	info_shdr = &info->sechdrs[info_idx];
+	modinfo = (char *)info->hdr + info_shdr->sh_offset;
+
+	if (info_shdr->sh_size == 0) {
+		pr_err("empty .modinfo section\n");
+		return -ENOEXEC;
+	}
+	if (modinfo[info_shdr->sh_size - 1] != '\0') {
+		pr_err(".modinfo section isn't NUL terminated\n");
+		return -ENOEXEC;
+	}
+
 	/* Try to find a name early so we can log errors with a module name */
 	info->name = get_modinfo(info, "name");
 
-- 
2.51.2

