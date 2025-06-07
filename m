Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C120299B
	for <linux-modules@vger.kernel.org>; Sat,  7 Jun 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313282; cv=none; b=HZs3Q3LHHNtxZiZ1Z9S/V7jPTkNCXxureLwMY50Gak82oNWdBRV0Bsw2IC66+2iRsgMHTDjgHlSLadHS3ePE5HCX8W+fE5NGQxai+iv92nVKF/fxiQKKjbVSRUtgS7ORXBp3bVFaC9K2l3Hnhi2C04uooDtuTqKI8RCPS8uUFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313282; c=relaxed/simple;
	bh=xEf5YgI028rHADc5kVooZ5wADbUeVnr/T/EysAZOuoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcRy3loGdvicdOlH9XZaA4NrY15g2017XfyB1y0eO9cikIbi49oxrZBTpfyRS8/oVn87SxI3TrWEdPDWxOAq5ReV63LIlr7mVoM+RF/xfbmVjJIwth5QuanVltMYgwa6vaVsQh0usIATjsfrbecYIYZXqRLtNQQdGgdOd73Cm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KruhDqfK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KruhDqfK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so2695860f8f.0
        for <linux-modules@vger.kernel.org>; Sat, 07 Jun 2025 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749313278; x=1749918078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTAHuwi5ob7zHOE4R3BZu1de8+m0yqDLb9Txz10vj3c=;
        b=KruhDqfKjuoCoG93AI7MYS6UXocAm2J3uAo/F5TvoTqlBFFQu5TkwXxkvEd0gNZ4UD
         qSMeTzoVlclPWwvi8sAoicbiRbckMo8ycj9pB4ByvDYwZFkyweBdolnCbxBi+nhAPdVU
         F4ud+B/qEt03bCKU9QAMRQgmwB6TT3mXMUnE5tCzpIkxrYbjnoUndskZb/6hVvo9gz9Q
         D4qVD/3z9uIOG1L+Q8+H/2cmeXzDxLSf/bkBrlUmYGzPeniR8BbI96o6HYRzlQosj4TZ
         gzO8BRpAzILoxwu/OsW0RkJL952uXLWNgVtKotheMzF1/37WKaxY2ZnmRYxhAcqcNFXs
         IQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313278; x=1749918078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTAHuwi5ob7zHOE4R3BZu1de8+m0yqDLb9Txz10vj3c=;
        b=Wja0bZkwjNW48jpCfoY6itaBCUe4xECaxsUI2hxhATtedkFx7udn02V8SN/HmRAKk9
         FmslRCkXacu47xVKLh8BLhW7DrKMnyd8MSUZ8PjAKG7EjZwLOMdAtinbzHVMrOffMpv2
         MOhVOBzf3nyaTDFQKfr7VcSQJMW9F9q3izLzVNkm/tQhA5KEdHukeGNv4QQ+DjpTYMqO
         OZG4NxWcelpYH+4y7U4Fv8VgBjb/VGS1NPqdlYXfUqgYz4SiOGzcEOHrMiZLhl/FQK3u
         50iAF5ujmixy6Rtldr8BIZRjRx/WlrRg38EQznZXkqicDNHRQUVFnIMbdQXp7qNC77qH
         4uNA==
X-Gm-Message-State: AOJu0Yz3eIWM2t27FqJceEcuoKrx2JhneckHrQuJ7OErUEsklKPCI9ca
	/2WBfNk417M+nM6PkxoIh/g6MDEqwforl1rdJ/A4spCXTRdwNIllZY38aho6U3OH9Lw=
X-Gm-Gg: ASbGncvvjwPj7ywzlixK3R1oOer3pHC+1qqnnAtLkD02274pugRx8JeEliK8xV2Qo9v
	fwkoNiCLlO7XqGM7AA4/lMz88JXHTPtSceLEvQT0cpl03ZRGpLRSZ2QGxyqL7LECJJp7H3WNydX
	vydjpqzjGGpW8lhd5oiV5J3RMwsmW0w8AgkRASVxwSGl73he/F7ZrCngXVlzH4n0O4roYnShqmg
	ftHlmlPRCVfvljWtun0+KhLl9aBHe/896XEXJDwnTmpPImNkofxfjCxQhUztkUc5F1TlAR+7JFX
	wGVn/OJccuIZKtaOmlcp2IAovna2NwrQBUucWwz3z0ASFczHan6hIl9n0kqWNYrVfG/1rEE=
X-Google-Smtp-Source: AGHT+IFDb592g0JwsMPxNtq/1ZdQXyvAnSTz4sLNKzI67/x8qJu7TqoYK9PnNj7U4LmghIJiySpvmA==
X-Received: by 2002:a05:6000:2511:b0:3a4:f7e7:3630 with SMTP id ffacd0b85a97d-3a531327cb9mr6993813f8f.15.1749313278470;
        Sat, 07 Jun 2025 09:21:18 -0700 (PDT)
Received: from zovi.suse.cz (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324364f1sm5088096f8f.58.2025.06.07.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 09:21:18 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] module: Avoid unnecessary return value initialization in move_module()
Date: Sat,  7 Jun 2025 18:16:28 +0200
Message-ID: <20250607161823.409691-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607161823.409691-1-petr.pavlu@suse.com>
References: <20250607161823.409691-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All error conditions in move_module() set the return value by updating the
ret variable. Therefore, it is not necessary to the initialize the variable
when declaring it.

Remove the unnecessary initialization.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 322b38c0a782..06511607075c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2615,7 +2615,7 @@ static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
 	enum mod_mem_type t;
-	int ret = -ENOMEM;
+	int ret;
 	bool codetag_section_found = false;
 
 	for_each_mod_mem_type(type) {
-- 
2.49.0

