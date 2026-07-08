Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DE3264FD
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473688; cv=none; b=Dbv5b0PEwf/MXkBn6JSU6uh3mvAgs9vs0AsWKFPmiQkxZJK9Hy0Nu/t2ZR8EWYjvrM/0tyvOMwUQ5oUQZ/sinsH79RmE/SoQpXiwReAYN++P/rFYw4hsl8+3L/gMLEIsUspxWAYlfIooxPq39WsIyXLmhmuqCzhdFUvKeo4EKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473688; c=relaxed/simple;
	bh=0iDTC6iQ7HU2MRhmbhyR3vQ+Xx/rnAbImlk5nSbmjrI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=klGmOtVpcCPHvSBdBHDtKBXWrIALXVTCqznJRC2eNw77J26ytrcpGqywaJMX8HhpffMOPlJaUyRFrAYr3hQd1JInUlCs9FUONATQkJYEDQ9nvbeXeQQGi44v78/3/bXGZqL1Owa6AkM7kOJipyDYPcLj3Nb/Q7V3QUE2pWHOG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxv/QB00; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxv/QB00"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845a29d8c1eso306453b3a.2
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783473685; x=1784078485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=49r50tPsVjGlL5O8jUrDgUaT0UYvkKRZ1jOzYL8QtlQ=;
        b=gxv/QB00cWmFuFZCNTCCvh/S4FAH81kd665Ipt6qhyqqVtDidmUlG9Mtov3qR4rEH3
         3vim1RneqCYqL4XUAwQ58m6+s+W5R5EHtl0IFViHet0LXxANTLKAimK3UAMoxXcuFA4z
         w0v9EZdeqUx0XQbvMJujfpvM1908CI/xaqTeboNuBF25QfWzrdHHD7bnzwDCaBEf/+2q
         B5UX6lOKm+u9WrrSifGKkp4/HkE32yx0dbT3NJAXA4vGGsxVufYIabcQb7Jc5uJhushO
         S60u/e/+xWCVepW17odDI2LWYjxQOZXJHYko6xbKeyIMmSQNfVWxu7fWSlNLWhUTQdl0
         nIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783473685; x=1784078485;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=49r50tPsVjGlL5O8jUrDgUaT0UYvkKRZ1jOzYL8QtlQ=;
        b=gZ4ywN6HIb8KOlW6sjWcy6psDjLXNh0MdTp7abxLMuRhX+JvHxz1wug783ueX4DTx8
         Vsmeb5NIZLZwWb6o7rzz8sbHJ2JEyLwzFoZmTeAfk+PPHbcz1M4mKmW7XkIp+62jrvSC
         /cTDU9PAWBywzpX93F9HweyDY5WnRlKUiMnjHbpTuqDLzC6ZY9YJnrCA5vlkxXgicb8j
         Au/h+5bpB7sChA8PxBLDuShUwQYAT0VZghe1nICo7tpH01kecL1037e8Uh0ctXsXb4FA
         8HU3kSLm1Ee3G8/+yJ/7s968yEAfcPP5yBRghqle0B2LbMUCsXLR1BleHnL2GhlLCyZk
         r0lQ==
X-Forwarded-Encrypted: i=1; AHgh+RohHBPkARFcVqrklDzwphtVCeVxoK0YH8A8jyg/ZsBRllTEV/VRkl2DITaJDrnuptMKFmqLE3TpsEuNJIa1@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlRCSAWXXxbfs9E+Rzze3J0iCCj6Mq0o9nrvtbHmk5V6RVqez
	nTxODrDEO6AIXq4ymaMnO+KeHWIppmiunNNxRW3otSMuhG0r0xG8zxIFv5P/Mf6g57IF4Y+J+zT
	f3g==
X-Received: from dldyr15-n2.prod.google.com ([2002:a05:701b:450f:20b0:139:b637:8de6])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a9c:b0:3bf:9c93:ac44
 with SMTP id adf61e73a8af0-3c0bcfea4bcmr140843637.19.1783473684556; Tue, 07
 Jul 2026 18:21:24 -0700 (PDT)
Date: Wed,  8 Jul 2026 11:21:07 +1000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708012107.1621513-1-tweek@google.com>
Subject: [PATCH] module: validate string table section types
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Siddharth Nayyar <sidnayyar@google.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In elf_validity_cache_sechdrs, section sizes and offsets are validated,
unless the section type is SHT_NULL or SHT_NOBITS.

Later, elf_validity_cache_secstrings and elf_validity_cache_index_str
access the section name table (.shstrtab) and symbol string table
(.strtab) headers without first ensuring that their types are
SHT_STRTAB. If a section type is SHT_NULL or SHT_NOBITS, sh_offset has
not been validated and may reference out-of-bounds memory when
dereferenced in elf_validity_cache_secstrings or
elf_validity_cache_strtab.

Validate that both string section headers are of type SHT_STRTAB before
caching them.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 kernel/module/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..7cbc8f0e28c6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2011,6 +2011,7 @@ static int elf_validity_cache_sechdrs(struct load_inf=
o *info)
  * Specifically checks:
  *
  * * Section name table index is inbounds of section headers
+ * * Section name table type is SHT_STRTAB
  * * Section name table is not empty
  * * Section name table is NUL terminated
  * * All section name offsets are inbounds of the section
@@ -2038,6 +2039,11 @@ static int elf_validity_cache_secstrings(struct load=
_info *info)
=20
 	strhdr =3D &info->sechdrs[info->hdr->e_shstrndx];
=20
+	if (strhdr->sh_type !=3D SHT_STRTAB) {
+		pr_err("Invalid ELF section name table type: %u\n", strhdr->sh_type);
+		return -ENOEXEC;
+	}
+
 	/*
 	 * The section name table must be NUL-terminated, as required
 	 * by the spec. This makes strcmp and pr_* calls that access
@@ -2204,7 +2210,7 @@ static int elf_validity_cache_index_sym(struct load_i=
nfo *info)
  *        Must have &load_info->index.sym populated.
  *
  * Looks at the symbol table's associated string table, makes sure it is
- * in-bounds, and caches it.
+ * in-bounds and of type SHT_STRTAB, and caches it.
  *
  * Return: %0 if valid, %-ENOEXEC on failure.
  */
@@ -2218,6 +2224,12 @@ static int elf_validity_cache_index_str(struct load_=
info *info)
 		return -ENOEXEC;
 	}
=20
+	if (info->sechdrs[str_idx].sh_type !=3D SHT_STRTAB) {
+		pr_err("Invalid ELF symbol string table type: %u\n",
+		       info->sechdrs[str_idx].sh_type);
+		return -ENOEXEC;
+	}
+
 	info->index.str =3D str_idx;
 	return 0;
 }
--=20
2.55.0.795.g602f6c329a-goog

