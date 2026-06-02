Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F319C3C81BF
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440524; cv=none; b=Rg8k4vNn7Wl+q63wYg2WOsW/P1ZMZ2EV6n+6O2XvSDpSEL9PRIoQ3d4JDU/H5eTVcnECHOk0o/a0cpDru1lioMbT8Jus6m1cy0BXuWWyovzqQVH7c2myniN0ow67XH3WGtayt8P/JiwQ083XLWT7VO5eiQ5wlQ/llpyuEohDwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440524; c=relaxed/simple;
	bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOICEwJhYCO8U/MHgplo27CNih7MftcBt59y1GsOP60MsFDSwMLVbOfNM23IZ+7mNKavMUMuzxQVDAl7Om/WReBmsf5KaMggIc3QQnwq+O4dhXEAcdWQvgtTrh/6yeF56/wfeJnSlgvTiPhWZbBFN/jsORWgYyYFDbMFwq3Em58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFuxi0H2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFuxi0H2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so4335742f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440519; x=1781045319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=hFuxi0H2UuJnZ64MYnC7sk1J7y3+R9yeqezMzy6OPMv3yOV9tOrx0vSkjnvoCP1MNg
         Z/sctMu6JTcTxu1ng+32FHKBbFWFUOHLT1k8cRTf6CB3MQoVyHJYMzhTJl9MNhas3JcB
         V4MK4N7d+0njhO7U9zJZmIF1t7HUEF2+8ZB9L/6ZPM+iC/mr8SeCg9TgPsWtxDADNJfP
         P3loPLaXlwuy6HgaGkizpXNQs9k3iIbojMWpWA9MLasUmVUomupYoYqFUCm6Jj2QsqW1
         RaN/FnjxN1G0Sx6sk/G+9685NCbRdv1EhOzDMiFqcv2nPPcvFKIlET7p+nspkMfjFBEv
         oZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440519; x=1781045319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1/UoMyrbDRBJtnX/0jQKUAOsd+dEJyLvzD20lPdR4ww=;
        b=q9T+x10fecVoSP+L0vhPIU1kKD/7sK6AJ3CWCz/HG+EFvE+CHIFyF3zmd3qteu+9KM
         PPaNAvS5ybRf9/hO3D9WGln0SgbF/Z+PaKYDEX4blx/+fMuMteJW5Jt3zcEdf4coOhP3
         zk4FTJTQkITdJTFDOod2Vp9g2N013SBuNjiQ5ckupOAxgaaasnLiINOIZ+M/lCQzQjjE
         dkU+hHdDjV6KrcxfxWiAITMYqqu6QAeUVcDYlXEOli3f/fHXfd9/1Xg+Inv0LLFbbaNl
         Y6Qw34kC0HSIwoVfw76XOI4EhN2ekpUSrwjcEGuhHdmrQSjI/zWg9o2xrxOplkEgvDV0
         4SMA==
X-Forwarded-Encrypted: i=1; AFNElJ/sQfAUaWj6ERDcSFbL7fCm2zB1iRk817nSnScVfe2ylO70T0YNKKk+RPtN5lWiGQ53HhrjCNo8s++1TF9w@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOV82/De2J41il0fA7BLB6/sYfDfiDBa5aNDeBLZgPSS5aAt3
	PgmmQUohC4ip/ILwIJYZHkfe5tOdsNWn3cu8Xl3vaqAEVE6Yy6WjiCmt
X-Gm-Gg: Acq92OFOI2J760ejy7krGMOMmLcBoKirW2NsrBO5mvcNZ6jWNLPKOlvmOWidEzs4Lq9
	kilmA6786pMhP+KrYEn0GPe6hHaVlx3qVbwhtrpjdaQka4NRn8PxD+tGltpz4Anx3DmBqGsDNxH
	4araB1/GbIb5MdJGqo4tX7FSo+rBPqaLmXsJ47WnRbnrLMxwmd7OxV34fx1AXIXbxpByL7n0L6K
	CF4Mh+lTZbz4mvfEh6snshXrhDaVZ8aH0YRNIpfz7vr6x5sMbSTebSExLV+1s/UIabAkDIqtVcw
	Cd6eE4k7X/sFq45bg7eH5AvkqDQZMfeO/fWhCH6U+kaIvLG/eP4L6usVwLpRJT2Zb0aFvHbMcJO
	fti0/swMm6aU0zSZ4yDL9R9CKTKxZv8GSnFwzXHYXyqHkmV6toIkuWgHPix3LnYO+yyO8o5DnOY
	W1nMWbwDo5dp63GUb0wJO+48an1Qn2pf81To+Ep5p7SQ==
X-Received: by 2002:a05:600c:458b:b0:490:b409:94f4 with SMTP id 5b1f17b1804b1-490b5fdcda1mr13028365e9.28.1780440519473;
        Tue, 02 Jun 2026 15:48:39 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:07 +0000
Subject: [PATCH v4 10/25] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-10-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1309;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ah9OubhC/0J+O5fnf6mytQN8u50S2Bl4xoeKfk7IEd0=;
 b=mY6va1q+pplf3oiRh9kAqV2/4rkm8Jt+FXjkD2G7wa/YV3UYCu8KlP74E8zHuHM0fBwUW7QfI
 85+dFL9KEusADx7bjdzgWA9Z4a2ALDbaZGX4b6jMBC5KuU25CaW5OCx
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports classmap coding error condition, which should be
   detected before review.
b- SHOUTING the error makes it uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

