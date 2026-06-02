Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAE3C871D
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440500; cv=none; b=FEsajwN1zLGa+ySqBEVOySbOprL2BURrRcm2CD7TxksJdvXHtfUoHuojzRABqM2sOELcCx63Vq2TXrVPUl92KROn7TO3qU55RaCkVXdN+y7U1vSY0CMTslkQLM1Om7EytP5fhSt6FqTCjccaxjBoTMFISsQpZ+ulriubC97NyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440500; c=relaxed/simple;
	bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmiG6oFxmHkt82g5PDImHx9f5el6kCAd0oFv4dt85SJjoGwq+vHCZyz/cKD9ta2Ew/rzf1EeZLQRlOGoa8L4R3aybo8ine263jYwpDx2/gyBwD67T/ec788ltdG4J+7KLPPb+LhQtyhKJ6yiO62ky9ayu5qiVcRiSW6r04t8vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBoE7Ur7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBoE7Ur7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a76757e5so24130675e9.2
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440497; x=1781045297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=pBoE7Ur73OododeuuifWDn5wMtoQL7yOw348/abCpfK/wllh0lM91/84CEnCPPeUT4
         fJH9skgUnlmmjnBdYyeP+IAJ4pzy6HFFtdaT+eP/+Gmz5BOkpVTt/kGFp9DyAx45cmz6
         kT/+ShtNSehFz/kg22vKaPjpJvBx5dcpppX6HUpL8tzb2IE7BledM1NliSG2aTr4Z+Ke
         6tMztv/L+f2lw8qnP1RgHkqnKztJdZNv10rFEUnCbCjhRUBxY/FoRGSCfYNRvtbsVqgX
         VGph0jT3Db3uuOwQw59gwpsDC3ZOj5XW7KaqaUmXLkDRPnwdRPYxlfUKZtyW4cVXCCYv
         OMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440497; x=1781045297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T5zD1QygmB8fWogN5M5u4F28IFz6bLgLGYRTXYqao/U=;
        b=iNhlUNbn/rtAscqDvGOPeucJYUftdlDqpTemIYb515fimibq1xGymyQFoeVdSekZ0Q
         +8Pt45ipLr9seFQj4Ph/EmILvaqz3DrHtC6YlKjQLUs9oNCdb9rTzCchzmQtkubD+qHr
         8P3J3q22DCjoleBiWLgv/fE1nzsVT+7nVpoN7byKn52tqei2HueOO4uQt4yRpRcEmvbh
         cQwHV0oL6i9lqodKD0ZsjkSK/G7ZXR/lv40/Xp3Fs8/060U1sIPYIsRHcMXlTNjRlLI8
         dBW9F8xdkAuJY0QCqQQ7oZJLycrOq4H/PxQ48iYFrojOsBwIw1MFVlqdgWHOCMm7uiBb
         8tgA==
X-Forwarded-Encrypted: i=1; AFNElJ8Zld4os/BmCfbRH3Hn9UEnwktafhIYFtg9N1WTTTb7ofuocgGwGZsW9fuqHkx9twJGycW/B7mES9M00XiF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uo95ocdRUoUedIu8qUoZeC4Svcy9Y/kkZfKvDbbQT3t7U6c/
	R+xomWkKCZO/CRJGkm7R+myHqWDCXMuUWFMQjJVwF/M7Hv2cqHZTNT0o
X-Gm-Gg: Acq92OHnIvcPfT9+bgPlcIVodFg4/Rnv0VygweoJifB0G1nKG1RUvLEg4E7DxYEdIck
	A0NopRxxjGsknkuhC1R/dSvrpHPMogV6JLjzupzGj13Ln75BrXKtF9Zx1CTLZ1JAv6Ws6zt4S+g
	MFz22kEtXjSICMtMr/ggGdAQMUBumxdlVv3s8TwOAs+ymhJeeu76JBN7EcRQoM3IWsbukRutJsx
	mQvXcY19qHA4B69nCJlrxbCjGHR7ybHo24aNrXp5RwmPn+KC8naN/UYuhejfUDMcwn2F/uDupTj
	sUMITz35EcnzBs/yPtqpVzIwDYL3Icf8td813uVjQDJ6OTRmSrXTzpsnht8G1ST3n5QUQkK2DNp
	bWMoGCp9S7PQbONsid6ePn3hLDXbQjP/AQEsgpsztxeCif2D8H4wfkuGji3SWmdr7bbijFeYnrP
	A6o8qSG5XppkYuyzK9CDn80/zRp+V1j4WVpnukJ0FN7g==
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490b5fe0e36mr10870455e9.17.1780440497119;
        Tue, 02 Jun 2026 15:48:17 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:47:59 +0000
Subject: [PATCH v4 02/25] docs/dyndbg: explain flags parse 1st
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-2-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=1814;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Ybb0kJKNd2BJDDcZYbhZbCACFsLVAC7m/M+jXCdbe+s=;
 b=iGpCIeDHPVfQ770YcsgKYXv3tJwW3O+XIWlcq5CIrp9h5VC/6DBVR3xkR4b7Qcc8Pnj13ieeI
 Y4QZse5sLQqBLq9EL6k0vDUfzHjGV6rne+yovUgeHPiSQqfDC5aN483
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When writing queries to >control, flags are parsed 1st, since they are
the only required field, and they require specific compositions.  So
if the flags draw an error (on those specifics), then keyword errors
aren't reported.  This can be mildly confusing/annoying, so explain it
instead.

cc: linux-doc@vger.kernel.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4b14d9fd0300..9c2f096ed1d8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -109,10 +109,19 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
-A match specification is a keyword, which selects the attribute of
-the callsite to be compared, and a value to compare against.  Possible
-keywords are:::
+Note that since the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword and value.  Flag errs will hide keyword errs::
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
+So a match-spec is a keyword, which selects the attribute of the
+callsite to be compared, and a value to compare against.  Possible
+keywords are::
 
   match-spec ::= 'func' string |
 		 'file' string |

-- 
2.54.0

