Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A848F66
	for <linux-modules@vger.kernel.org>; Sat, 22 Jun 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719036848; cv=none; b=pftsVVehX3vBB8b4vwSXVqY7jGAQ4CtSmBaoNBqJu7i2IcFTmAcJXFFR8ji8IW3T2AbHDyEcgPLH1/fw8DzxnLuMS4xzukKpQaiUVPXFVvMADp6ZIhkpuUzynf2ohovpfoqJfzDLBgvOx/aJiZLz1+19yaA4JCcORATjT/foAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719036848; c=relaxed/simple;
	bh=h/IjfET7ez8AYRyIFvaoQkPN+krHsMVWeC7SXEWS5yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxxjpPLm19NW/96aGVZyCkPAXM75xPFMwg/gMhALl0YGwFeqqd9U40iDRF1BInGjSpkMmC8h/qzgNC53D+nTNJygYEP5rr+NvevZgKIGZGd1b7U2fkTBI7G4c/hFOgjGQLUl2sk9zpkBj4+lnWQDmydINIqfaz5uIQ/7LLO5Cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XehBcwAC; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XehBcwAC"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9cc66c649so1253259b6e.1
        for <linux-modules@vger.kernel.org>; Fri, 21 Jun 2024 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719036846; x=1719641646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NrBjkhytinXBl1PgAM5CGH+cTVxLyspm63vJBkhJsM=;
        b=XehBcwACSHPF2royDNPEufeGWDc1pe/t/cwrPzNpM+RpMzTwE+m6zrTRp9+xasRwbC
         /lyKD/AjysHz9KdC15NL/sLShQvuWuNzuhKhC/6H0XwUKURVI8PsxNLopzCz71+j7zL7
         UH0HtvP60vPWguASwPbiLNW2ruHGGj2qDzXVGj4v8raurrHU7oMHdNppczhM8iN0/1nU
         xF9kmzvWB5/i9HAe+uSPlNWM1XQvwtcf/Hb71LPfyED/uiWoK0ZnzdHAjvjM1BkHV/3S
         qHlgKhwp5XXmZtnAQlYjT1qnBgQu3sjlKsjSBoD00YIXSKeZnYTvJITGdRskW1efZXQs
         /QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719036846; x=1719641646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NrBjkhytinXBl1PgAM5CGH+cTVxLyspm63vJBkhJsM=;
        b=F+vwgYkKPoXcHnN9S5RzaNLqta3JK5RTk+UXoskSpfN2USuDyVxUV0LKvxA29aU6cW
         lCXdkyIX7TEKnHPGFQKWQPVlEnA+euJ2qBzPAKRIoPcprl4CXWneEAuYucKxMMz2wf1W
         ERFARB72UpyLvfIDUN9SOOkJx2KilfWEUIpCZ4N195ADf0H01qjxZFcX8iguQSs0Ez8w
         T4bhdDt8AUiQZ86VLI5k+UpwtzOM2k5iPciAUZXqJPm3Zbc9TCp4kqWVC8pwjaEfCkJf
         FjNdE0XC4jQD1XeLGg7uw5hthA3JzY8zLkDCVuxDJDAHPqN3tE+Q17qqrJVcr3fifXQa
         lR3A==
X-Forwarded-Encrypted: i=1; AJvYcCU3hG9fuFUfUvB1eO6HwcKhRcySEAza/OTNcevUtk1anq72+Kd+/hr8XonrnBeKkg5yR2ltgH6MybswrUbe13TAesjr3sHKEQ9XuvkZPQ==
X-Gm-Message-State: AOJu0Yzbq5s/hqJ2JJpdqvGnZrMYj9yzTPkM/VpClSZ9YD80+rJvRx4z
	aLX3t3TcUOjg4BhI5I5ZGohdQsYNTqWqpl/kkCScxBnDn9GDzDf0
X-Google-Smtp-Source: AGHT+IEzzUIcDRFLv/YBrgQ0tjPr2JwMi70tOZ9FtvcdkXsCjh9B9Sn7tu23Nk1Xl6aPrHFNz7jSWg==
X-Received: by 2002:a05:6808:1a1f:b0:3d2:28a9:4750 with SMTP id 5614622812f47-3d51ba66f34mr12362288b6e.32.1719036846435;
        Fri, 21 Jun 2024 23:14:06 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706622dbbcesm1041465b3a.120.2024.06.21.23.14.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jun 2024 23:14:06 -0700 (PDT)
From: yskelg@gmail.com
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Michal Suchanek <msuchanek@suse.de>
Cc: Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-modules@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] libkmod: fix result of comparison of unsigned enum in kmod_dump_index()
Date: Sat, 22 Jun 2024 15:13:22 +0900
Message-ID: <20240622061321.9005-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This patch fix compiler warning in kmod_dump_index()

libkmod/libkmod.c:989:11: warning: result of comparison of unsigned enum
expression < 0 is always false [-Wtautological-unsigned-enum-zero-compare]
  989 |         if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
      |             ~~~~ ^ ~

My compiler version.

$ clang -v
clang version 18.1.6 (Fedora 18.1.6-3.fc40)

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 libkmod/libkmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
index 213b424..fcb619b 100644
--- a/libkmod/libkmod.c
+++ b/libkmod/libkmod.c
@@ -986,7 +986,7 @@ KMOD_EXPORT int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type,
 	if (ctx == NULL)
 		return -ENOSYS;
 
-	if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
+	if (type >= KMOD_INDEX_MODULES_DEP || type >= _KMOD_INDEX_MODULES_SIZE)
 		return -ENOENT;
 
 	if (ctx->indexes[type] != NULL) {
-- 
2.45.2

