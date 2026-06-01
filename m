Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402D37F8D3
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315532; cv=none; b=NRfFKIGY70hhYdUJDd/rx2qeb0iioxpJjiR19yclqMiaVB1spJsP90S7NECNyDBYCXZjrB3/ggpRbdGijsAwYdcyRATLLCQ4JYsBHWSkdraPTphg2G1uFe4uDtYD7b4WALVcGRuSodW4xB+KgWOO3NY1VRwHwihx5q2v9eh5jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315532; c=relaxed/simple;
	bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFRMo5WRPG/Au1v4d0EGg3QmTaIC5dvbO04SSp4r5KJ5UjQVziDuq1sgIkAc4jA/SfmY96+D/+Cf/x/WblTo86JpUO766xflrG4/MboeW2bUmra5ch+i8oZBC+wYGn1QatbyzXIEdBmrrL3ZXI120SaRYPOd0gvED1MtiCZL1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swfwETCQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swfwETCQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so4192875e9.1
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315529; x=1780920329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
        b=swfwETCQllHy8HLl27pbxCddXKW3Y3AAHBaypFWm6cKwpG92KujpJqieN8rJ4crmd7
         9uApOcOU7G7jTiHIGrCmwRywKj5byqaKS0LestVISxeKyrSRRQvJ0pIqyQ9Bs3pGfg9N
         jgfS98psZgwQKwklvvwj5Za2buqn4Nxnf43BSMYKcF5agJvk5q6RNRlRwEfiUTbHs41u
         ISJ1o7+fJ57da5JJbXFZ/VLysOCq+OKIhVOe54N3NnnknmKXhE7BEH2WHXiqFKsJj6ro
         nOHffTKO6SsOofqPtxE3eH3htgdYkovWOHgaRAPFB/YB9YwWZwYQiF16P22WNH3mAqmA
         QJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315529; x=1780920329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TGR65ICT1aK9aLz3a5pYWL7xsIsBQYnd5g2GK/yOwYw=;
        b=jljvkbohJG+XDgkEJYbXtvfijs4yRxkK4kW3/wSqXFbumdF76iR1Lgm/QvMy4b6o6e
         iuES6BRNnOIx8uE7lbMP8dwAEDcjE1BwehrpIwpCQ1/tY+hO6j7iDwaqvQ4yoytS3Z81
         KD2S2BLpESgFER4oIJd3mVSxKaza+EVahIDypZTSNZrVMn/+e22Y+CKhRkVnx7XL685r
         ngYdIDHIR1FT2Vx7tLorHliQW2SNcnlbX8Y6NNs0l+Bqd+PYspW9Nyb/cQG8+cjN7pK1
         SEu+nKvx3YjoLKqn5HncGqni+0c53pPRf/C+UvqEjzpstmau0NwfV5EL2TagAaWrZ3ux
         HnRw==
X-Forwarded-Encrypted: i=1; AFNElJ81G5BwPk6iyTEqJ6OuEjI2BQ26s8r4n3lQ33Ig11JRvp2M7NVLxn9orZbeekrTS0LBkDZy1y0QXzXJprIe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+CEqD4STFyTgQhZ0QksV6nZ+RLTWul1mnLv5ZyTRB//kNc9po
	Xuj9h3j1L0ly84kw5Wn63za9g6VcJv5YWg0Wzg4k8zkoF0NK0k512ZHa
X-Gm-Gg: Acq92OGq6TV8ls0DCdxcS6G57774hORnqb9VTGpWdlm+etsuc5reN2ks6v9TTbPRzA4
	oKCco6MHPhtpWSNMlE4UTslFKXEHkNDmLMSAvDAkkqa8t9L72GkUVrwEMUvykvCoY9QDUrDo317
	pzCGEA52+HUOm5dPD+g9xd0Rpvk8DEWageH+T6VpqWC0nZqlKEZSvQXI6APtJiCEFuCnY/4laHx
	IJVfo2Yq76k1SBrHsw04aJ6NEKwUEx1j9qt4/jUiuvgnHt+O5+ZruXvD+/rJrFiWkp+i3EkcZ6c
	5lUUfiX0wispkYQqs9MSYQfUA9ymfCyI+CF5U79Ru/w57BACLIhETMYoHkxfzgHFbBPkTTd+bSu
	NFpw1lixXzZaFvDEmwHsC4JEwOPgR7U8QmE6y8YFuaMwKw/ZnfuIhGkYLgcvk5b1cGDKz/YzBkS
	vT4tohSMJgE+dhwc6khEcAPYqENjOB7s7gzDTzWNterw==
X-Received: by 2002:a05:600d:4441:10b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490a2948034mr141224245e9.24.1780315529177;
        Mon, 01 Jun 2026 05:05:29 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:58 +0000
Subject: [PATCH v3 12/24] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-12-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=1065;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UEhkyuT+BoyqFKDfW8oKnsP6vZUUYVyVd65DI+YPTOw=;
 b=6Dddfxtl4gMoLaO/5GP5/dyVmNyQOwcvkR2lM9WQtjic7D5PcmUL8Jdh/MJm8FRhW7WSKe5fr
 tDjKU6mMNzBBSyBqZxxHUogeQgkpnJ46lIJQQrTED6k3CUybbznd6pc
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: include linux/array_size.h, correct commit subject
    review after sob
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 78c22c6d2312..867e3978675f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -121,11 +121,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.54.0

