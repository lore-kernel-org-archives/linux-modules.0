Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645823054E6;
	Fri, 22 Aug 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867328; cv=none; b=pJ72064JtjW3TMH6ipP7s3v8E6nOZijBt/h+UtHdz5NmEobMBtPHsYUJ6G51ECjgmg3gLTNQc0UMolxiTNQ01HbyAOHoa9q1jaeXxqq99mYOTyPkWbQCsRbEgxTgawuh8y9vTkbwrb9WXC/EFFZEuil2SvW7OCYMMb5KqfDrNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867328; c=relaxed/simple;
	bh=fS7tcc3pbTtPPamWit3eOd5Xqy7QnEiA95Q4HrebIfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3BYK29OHswEU/11pQJzbUGCzQjFcCPtkNiHzzXbfNSE7sKXdGvtA2rJxMsse9Stz9WFSBIuH9OOeb3HZOp8bqBrOCy88X7LTtqHaKjF/MMC2xby3xjlsPkzWwTqK87mgO2GNlGmE0qGLN77X5ws/R96hrCWEzuvCdVrElO7IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9KQ0fpV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9KQ0fpV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24626e06f04so9294325ad.2;
        Fri, 22 Aug 2025 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867327; x=1756472127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0BMKCDKNzT45IkwjHH8qIV9wptfqQdqs3ianpNZIF8=;
        b=G9KQ0fpVjJlje5AhI69AaIUjc1LytHsL5WoAZLPdUmzi6NPX7CfGGKwEwx0WcJTh6K
         qSL5buMr3rzzWgB3sVtG0JXHC7pLmoqXeGk5itRyvGrVW8yizHVCRCx5ZNAhCVew6CzS
         tUGG38yG6d8kKJKsKtyAvAkAa1sXqpR7TkuvG4jp9GTZ0pLPfmK/j5ykKxRaoaHZStR7
         Hze54SH4eaPvhAlEEKjbaNQeUy6iboBAsa6DJV7oho3m9YQpAG7aZ1riXtcButGP+PeQ
         FHUKAIH3ZBA4sM+ZDCb62xhrl8O9LC3CmsoMRxBc7JJGrQS1Be5pWR1p3wOItHGe8nRs
         w4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867327; x=1756472127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0BMKCDKNzT45IkwjHH8qIV9wptfqQdqs3ianpNZIF8=;
        b=D0IBHKj2ozs6iPmNdWZFTkZf0PBZGMzPxJW/Lyv1nXBcLL5YjCu2BfZ7wORTzG3q5G
         K6ifDK/u6f9523ZjtGHTss4QRltQVcg80zwexR1/XgUxoPZn88uPveDn53KbTYSMrJcg
         QagH5MRDNhBo0/GmiqBdeCXxtY2NOFqiz/nSKyzugwtesXUGWg9+YlDFsI4la04OPoRL
         dE/7QgV46wy3S+TXCUB40z1iTqSI8VHZkW6+1wc7l516FDk8wFRlcEHUc+bU/MHLJYMB
         eBmriDfyqd8rugvUJM5mKsgj3v34OxJmV1a7KmF5qo/LqY81QGwZvO6E6pWymxWTCMT/
         Vjog==
X-Forwarded-Encrypted: i=1; AJvYcCVRkVpFGgmSMfpD/CaulDSmANQC9PF4wU6j4B/p1ZigwMioimIYZN7cdOMrUNq6c5ddhy5H/UDhWuGObv7j6w==@vger.kernel.org, AJvYcCW0VKwdaOdvgN2kTaseB01bSPD8QF7IHDYm+aoaDNTTvQTHm4UYdo5JNejWNFXKV/FCsFRLMj3dzzPkv9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYQ4rdj5LE7OHHKRpPKK7ligFHPXMX2Prf2zeri3H3cu8otPW
	zI6jR2brYsPeDSXTSExSsbVH4fT6s/AmX4wZOQVOuLIjw/U0tUgtWYBi6ir7ywxRnR4=
X-Gm-Gg: ASbGncs3KXtUxqAC8KBlUF9ld53+aDwxuUEyRKn4wPmeMWyCmIbMNVyWl65TMJCANNI
	QPdI3jWowkwiK+AWcyu9qCW6YkE50SGTy9TJJLki/cHp1NjLQwogDTD7Qga2F4dHNDBXGYMeR+G
	192hI1yDvYeByLYJ/NJWZYLoye/lO+PeqXgsjW16W+XDcRq98YAxUsTiPyMtxO2tIPP242gRyRO
	PevbDZAaXd46N6TJC4DpBb5CMwRVTMfAQA26bHVuUUwRBB5zXSB5DVa9l4ytyXpJ7BxZ1P8tlzV
	bDCdv0zJfxJK/FVnu1G26OQU1OkhlSlqZh/UM2st6TBOVjo4IhyryOptIMeVIHPu9lGIAvgEWdk
	NELpSRcvsxdJ9gg+H8w7UUYxYxv2gPKgDHWvXi0cTCiqg8UXOejz+Yc7LSWGDCk+zOt5rBTRP51
	0=
X-Google-Smtp-Source: AGHT+IGe9xjvRCbm5KB6XLhgwUqmolb7H5vCwSf1+FeiK1gVWZ3mrj8iBWsJGAOkiE2ig10Kuikt9g==
X-Received: by 2002:a17:903:22c5:b0:246:61e:b561 with SMTP id d9443c01a7336-2462efd975dmr41616535ad.58.1755867326536;
        Fri, 22 Aug 2025 05:55:26 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:26 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 5/5] module: separate vermagic and livepatch checks
Date: Fri, 22 Aug 2025 20:54:54 +0800
Message-ID: <20250822125454.1287066-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125454.1287066-1-wangjinchao600@gmail.com>
References: <20250822125454.1287066-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename check_modinfo() to check_modinfo_vermagic() to clarify it only
checks vermagic compatibility.

Move livepatch check to happen after vermagic check in early_mod_check(),
creating proper separation of concerns.

This makes the module loading sequence more logical:
- First verify module vermagic
- Then check livepatch-specific requirements

No functional changes, just clearer code organization.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a426bd8a18b5..d30bffeef63e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2571,7 +2571,7 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 
 }
 
-static int check_modinfo(struct module *mod, struct load_info *info, int flags)
+static int check_modinfo_vermagic(struct module *mod, struct load_info *info, int flags)
 {
 	const char *modmagic = get_modinfo(info, "vermagic");
 	int err;
@@ -2590,10 +2590,6 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 		return -ENOEXEC;
 	}
 
-	err = check_modinfo_livepatch(mod, info);
-	if (err)
-		return err;
-
 	return 0;
 }
 
@@ -3334,7 +3330,11 @@ static int early_mod_check(struct load_info *info, int flags)
 	if (!check_modstruct_version(info, info->mod))
 		return -ENOEXEC;
 
-	err = check_modinfo(info->mod, info, flags);
+	err = check_modinfo_vermagic(info->mod, info, flags);
+	if (err)
+		return err;
+
+	err = check_modinfo_livepatch(info->mod, info);
 	if (err)
 		return err;
 
-- 
2.43.0

