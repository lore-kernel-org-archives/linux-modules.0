Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CC331EB9
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010490; cv=none; b=Chwx3v9ah8LE8r37I6qYGnmPDS7NDhxMu0NgBDdAchrHlIaac8LB8JjejIGeZEWWiFPdnEkU2GdQ8Fu48CXVTxyNo82nRjf/Hp3GEX4p2CPIVpXFsJwac6zuSc7XnrT1tED+oY55KzQtOK4+DQcr4ffebmm6syKnqfLj/ccmDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010490; c=relaxed/simple;
	bh=DQaYrrCHfOWyw6I7/Alb/oOYcgAlY5tv2FwAXCcG82Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icRZGL77tKttl+Qw0W/baZwXyBLJSNYmTs2jf2yeHtLbRxjuDA/4caT1sjBihPw6X9pEQZsWrs6nX4KMaF5gQgsSXsdbyPlstGyHq2JeN2J2MW5ZiWPsnF6z0T6kV0HxPZJnp2C2Oevn7JqW4JDjv9xSPYilGDoeBThyZAOGlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvwo3Ggb; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvwo3Ggb"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44cb68d549fso343124fac.1
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010483; x=1783615283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
        b=Pvwo3GgbtFTfmQ2/AdoM+nDfVazqkpfwtm0LFE9i1gL1GilHvUlEh1VCGzyBsJ1C5w
         rleQNPRM6TRM/gaWS8B4BhPUDfWB6UUcMMBxzmkh3Wbbhe5pFc0PvZOVJWjTV07pxNY/
         XRymfzNr4kJnaNhS9GOXW5OVK1Jd+l0KniKyLUd+/KX0lit6hoxttkyxI6haeaH0Mrg+
         u1ppyyGx9TC5mDkaAUnCli+IT5t9gctsOlJu/wH8vSVS4/saMXb24mrNJyAgrIkq7zMK
         Vy0UYTfH/O0dzPOboMg6kgdkW76ub9o++gFldcFxreMk8yeKMci7KLFCUPxxVQ+C3Ji8
         GHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010483; x=1783615283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Er/Iig+CT06OIxgKVI6YA3M1QIseY8trv6Rj+aIwPm0=;
        b=PiNZuzOUNChoY0OijrHGPW5cEH0Lf9qarabkWgbdd+eSX4flHMntyurc9AxcTE2CDF
         4UzIzoBRr1Hsk55qHZjXfzkGKpEYBbLeIHMZMmu8J0x3K9+NbMdA8DJzWUgiru5XVRVR
         9Nh9D2miBovlUIZHzm5FVUsYXfUZS3wSHe/Q2YN54rWgn1GHNxe6O3KQ0E6wqfnMOiS+
         GlpNhJhdsF3Vob1Vhn701gQ6YfPQYAYNZ8IxRbvOa3zKhrkdgkXSdM2q3RKd1BsV1zNE
         Sjk8JsaHzIu5bAn7yLOnFrloy9y5cA8rvXwEgOkmD61OrUa4S2VmU/5OPtZwQbklmahV
         GqUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtdE4bxHZo8IctZsoq7vZwtIfFnjqYDe2HlhEVX7cW2S9F87CaTJdBvaKKhBRw063CAWpQwok/l8OifB7G@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUNbZ2xfelWy2jb2m/ITM1dGH7Y7yeUfIFrB319m8YVuNWGYx
	E3pdqcnG5k+gKixfbmZFh8JMQFO03AdHtLgFELUBRbX3FmTxZkq8BdTQ
X-Gm-Gg: AfdE7ck8l79/+BUjETp5lUMQZ8hwJS2QOwkHLx6meq4HvTQiOU/99/FVeKbsoxwGw1P
	s9zVj3/CJpUz9udJI3qqubdjpJZJteDpeISPImvX1Izm8rNj4Fllqyvg8xBQBj1ad0WcT1hytuK
	LVYUWicgzBJg8Jsr3joHlFhFq9QmeqUaOu3U+fE/PbQ6QSBDTLiRmVZmjXh5tUHe298Qroj97A+
	ODf2fMbOS90WrAGE6hcV57RK8V1vutDc0PWFeWlCwSH1Z7oxBD7rvzzlP6zFtVduqLYQLeyWYXf
	18ggx0knFxPpn14//g3K4cWE+lvx3ryhwvRlEnoirxoo5Gf3ReWS3TWYeDS/l6Frfn5NMPLxbn7
	Q7Owv9++S+JUtioyPQSPfc43UFdeziASKfgp45ufYsc83itknV6Uhq4CA22qyZdluxTkdaevm+x
	iqa56yO4QhqEPnT/14REt+qj8rgXij/0CHqavrwo3+WnrXS1sSy4s=
X-Received: by 2002:a05:6871:408b:b0:43b:891d:7c89 with SMTP id 586e51a60fabf-44cea45e2abmr371405fac.11.1783010482676;
        Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:57 -0600
Subject: [PATCH v5 05/18] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-5-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1538;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=DQaYrrCHfOWyw6I7/Alb/oOYcgAlY5tv2FwAXCcG82Y=;
 b=GFSnTtMH961Y7o+VaLt3lNBMKb5UiiKt2BLUAkWCu4TCnoTeTkKBd+sR212fvqeMrEWN2Opcz
 uYRSplmYhnZAjmAT8j1DEyjDJT0j/OaxPRXs/r1ayXuYUbIjiGKHIRN
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..9ae1accb9bf6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

