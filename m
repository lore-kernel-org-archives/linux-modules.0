Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAD2D77E3;
	Fri, 29 Aug 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457396; cv=none; b=GujijVqCqT/UJ5Qi7EtpZlW657FHcYby+/74p7GTNvU1jklZ2fYSl79lZr9JLzbhu3LvKnwXCAEcWmoqV+ma4n2MaN/THazRsSb92odrpd3BDzoNWNGVCXMv2i5ey5n4oOEGdZl5CAnPJCFPU2f7pbc1X/5ioB+CTs5c2qgsOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457396; c=relaxed/simple;
	bh=G6Dd1uqb37z6zSbzhuNpcxLh9MKP3I+uJo5S26l1UeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouFtp2kizvJabb1OiOe/2rkIPPakCtBfk/FYs7hJ3r+5aogWSRbjl9j2bMu/D0z7jSoh8ldN4HmbxFiM7jD2NaINP/dD3z2AXStZrBLJcPFPM9EJER7dZGwPK4sL2MSpP4FsnYf44fpLIrkEorbgPTgT+tM/kzKDf0aFT7vogVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOEpH3vo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOEpH3vo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b471737b347so1259289a12.1;
        Fri, 29 Aug 2025 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457394; x=1757062194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaClGvcV3jmxIulwFuFHgeLeNjTELgbREuj9VBnH4uc=;
        b=BOEpH3voKkKC/s6XHhagdo9yZcdvekz8StzOS+WTMarCAG4slaVXVt/5llLcIzY1bJ
         L07gxtTLto5ebTZ+FQb1DpMARmG6bI2s0zNOjWpz72dmBPGlYnWbM+qdke5n/vm9Eks+
         HZN+91zjd+r+xkrkijN7szI6UWo/Y/NGuTLQ4SSYFVPr0qftL/Ph3aySZvYsQZOj3tGt
         zjU9mtXIE5fsvZWclaQQ+mniVTLLMcoDPyXVCVs7JrAnQUJwzd4GH4KXsVPdE+ciPdmo
         ZB1dSbDcYpxTT3ai2TzbyWqr6xrxLW67QXF/0zxuvZjskoiX7gwG7n60RrJS6Ry5MUrf
         wOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457394; x=1757062194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaClGvcV3jmxIulwFuFHgeLeNjTELgbREuj9VBnH4uc=;
        b=Z6/biPwge9VeawWqoK/YfRkMcDyMMpQRU+9Q3dIvasPHcBc6Bg87MEV5ooqCyxzNdE
         zyuzU5Loa8+00Gw4RE9/MXuOS4JSRjddoOZ4UJPRv3GojDgF7G4vwKqIIHuvIaYXOJl6
         YoVWczspjstKvQp0HgURg/Hnwj29KqsWn4imCu76uimYCYmPlrlG/p3PMtTATYF2R5G8
         9pMkbGxmtKjn3myAcNvxZvtRyGiGlTOU0LILDOKMRO3Vi5Z3XgH4BPegHEIQ/N2+Q9Qp
         yDgkxcQO8oJ92BPIvrdda+pY7oYSZx87vLVldurRwp+6KMo7P60cmKphjVHrZAwCadFF
         BxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXIkDSrplmK33xJ0uVQqdmjpbq4B0W7X4jjcL02Bc4DLCZPbhZBPsJprnZFzbJmEmu7px3P1kTmz02XB0DL3g==@vger.kernel.org, AJvYcCXabFc5Di3V4CbUj4/BISjGUcul7bruL6VDiNtkMV27mIusf+yWlXJLwxdu+A2Y27nwtyzvZUes4AJmdRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0txyCrNsG1kwUL1RiyaywMVSttT+qkbpiLiO1MQlKlu/wWXN
	UWK5AVE9N+2bBrt+OpULZwYb/Qxz9MWR6JM/jfggcy0i2x5IGHbjGAIq
X-Gm-Gg: ASbGncsC05v3ANapvIRDe1xuHfj/mGwDPk2qxDVj+XpS2afrAExJDRMg9AlFU0bl+N0
	p/hJjupYqQKV+XklHy1kzMixs07eHzDglfeGefbNZRBe+TMbkpF+7tc4qf99ktaVQZ1d17GB4p4
	w1OHFapdXkKjLmNnecrq5P25LcvZDMi7IePV2xK3+iThBHqrodINCROrHdT2eLIfHt9VKqrFnxW
	UgE79EVSeN8/IW08lMTaMHsAijy5JJcW1+A9Lz58yb7lRbOuV7twzq/EH2exl0a7QKVcg02Ahh5
	HZsdvzFNpoh5pL0WIKrbobbIzyvRh6ylbMvSfF1wcVMUslJMgnPOhzD8En7HB4YQftl7q5f3obC
	Wbs/PTbEhsCLM2wj6EzsyjCpW10G9CiSNMQ4dDS2j2x419VZR1zpBMNCKyloc9a2mLStkxlE=
X-Google-Smtp-Source: AGHT+IFEyhZkAgy6mOMidTOL0WB2kvEKN3fZkModigxlDVFNLiE7scoqcUc8a94lCh8zpqLFUA6UYQ==
X-Received: by 2002:a17:902:f542:b0:249:2360:6af2 with SMTP id d9443c01a7336-249236075e4mr4297385ad.16.1756457394091;
        Fri, 29 Aug 2025 01:49:54 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702980sm18561865ad.13.2025.08.29.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:49:53 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 2/4] module: show why force load fails
Date: Fri, 29 Aug 2025 16:49:11 +0800
Message-ID: <20250829084927.156676-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829084927.156676-1-wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include reason in error message when force loading is disabled.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..e7484c6ce6e3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
 	return 0;
 #else
+	pr_err("%s: %s, force load is not supported\n", mod->name, reason);
 	return -ENOEXEC;
 #endif
 }
-- 
2.43.0

