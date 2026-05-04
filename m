Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374231F9AB
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927547; cv=none; b=mtLASXqqiR2iNanbVVzECPfhcUsdZsACcu+SHPcNCqfXxpI40P28Ee4z2enw4LgXb6Xq5vPOQekewPhK3Yk9vJv3QvPp66i+tY16Ca0J+GS53Oy6/bWscNTs1EhK6T5W8Ggqc0qZcnHClcuZM4wU7H4L9lXX2DSSyr4lhzuhWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927547; c=relaxed/simple;
	bh=YZwMAR3uqET/bZH1qZJj95QcpN0V++SSyz4QoqNaiUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ld/hMq4d51OnLTvwMWk6cqeSMY7j6hMTp46UJgtvXu2tRMWRXyeqDmIJ/FlpSwtUIgKtMI2B7SPA6Av0SLw28158lvRZwLFpgc3yYo/LBHXebbVrShvJu8teDfmWux49XWAZK1I69iWBm7C0KstEWLJqAw+1vpiV0cdz2fmP+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+9dnfDo; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+9dnfDo"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6966f99716fso2279686eaf.0
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927538; x=1778532338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nmzwB7G7wQji/lU/ygTPGmrlGNrlrcnn35fzNwdq90=;
        b=U+9dnfDoUWfFxRDkfXIu6OMMgD7h/o5jK0z87sroarYMb4njliyxoIDWfMdFhdXaXs
         wdmzWDL/VnfXvp6/c4GXJHMhI8Idzkyw0daOoM1YiQC2scseTZHODpGU+iMBSE+he/b+
         6cYBBxc6eRElXH42gep1/69pn+Gv+L+Ho1T3qvfjN36DuJnxtIew3ajoHB4F5EFb7DMq
         7vfflndq0yfRDbdv+duZnj3PNmJ+uGlwP3FgrEaYCOsJ9j7kchGLiww+78qE6XtTNMDi
         BnU2WFOeVTcij0ldHSUHYHR4iHDkYcWmu/tTwmS5Opg50ZcpEjthFNxHY/z1KSI9IRId
         IpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927538; x=1778532338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nmzwB7G7wQji/lU/ygTPGmrlGNrlrcnn35fzNwdq90=;
        b=MtKxrS9GCGdHUZC7G4l0WIJAYkPpRg+9fv25VQTfHO2AgD/cJMVcnOWXZ+p1WGy6Wk
         JZBTrkDhjTSJ9CRiERzrjmE843VeS/X0oWPTHQyLhEKKWDB9v5zpdR+hgiEk0fUaeJaT
         in0lv/N3ocsuO16/dEWD7IwS8G3WMblYnuGd66uKOoC/p8kaFocJTmz+rYG/+bCdmzRA
         ZwO7fevyhiS8HqyecGeNFtk/zPJ4WWS5wwD93JdVGwjMV7k/6dmirfdzlxxnS3nDrpzm
         OSZPfef1NQwnaz56TPPFki617M0WecP7kfp0Drbh4OdMWj3ewarIOeP4EOC0FzB9qH/Q
         fmqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CQaMSOxbFcqknHZbZLi/ERBGRGVNvsFdX3UtCR/5BDV8MVow1uleTjxFNpSXmtmkBei71fruW9MWkEZr4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+fJBQky8hqu80hTq0WSPWEcFPGvDa/n2Vg+pVPivKSQJ4KlI
	9HjDCkkQ0+lgPgYHcKOxeWEcvjS01DXcl3gdHm3uL9vL+h0cy07mm73X
X-Gm-Gg: AeBDietVf5x1gb7z9G0YekJfXSc0fFnO/JHBG8tGyJ287P5Q8VVXJmIeIrur0fGZFoB
	I10oq9XeG9jeZDHUhQxGhTa4XdpX4EHQI7nL+VXWTRez1tDtKBRLnlH84xmInNTfnNYN0jU4CAw
	4GXJUZxDNevlFAj8ROzF0e60y1MqtrjhMMvABWZhjTflgxFnBtADXQco7Og6nThb2D9rJDQRi9u
	KELHy0eeMj7gHZopmdPVWrBeSZNkZKVQU+kSbCgSkUJP3SpaDsgjEvn70DITW9NPATuOVaK1J+T
	YYULghzaDlLc/8InaMiixDuu+hqUZq3Ap6BgYQmuLF1zIyKm7cczqoyQuRwbIoGSk1IttKT7XjI
	Co5DrdiXF+E+O1gINYGWhQkn6f8I4tEPnk0BTv2A8CkYeZ5PMIKCtjzpy0WAnre53fE8rvYjxAX
	eeEaBqfOk5rnCL7whQ7D3pMZxLWLJ3u6xybeQirlf/JKDoUc9sTZv3h2RpO3+WlayFVtkAujDZ
X-Received: by 2002:a05:6820:2908:b0:696:14c0:3f9f with SMTP id 006d021491bc7-696979ad3c5mr5336413eaf.11.1777927538248;
        Mon, 04 May 2026 13:45:38 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:23 -0600
Subject: [PATCH 17/17] dyndbg: change __dynamic_func_call_cls* macros into
 expressions
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-17-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=2145;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YZwMAR3uqET/bZH1qZJj95QcpN0V++SSyz4QoqNaiUk=;
 b=eISda3doke6ER4wdyvj6HcSygG7ahPVJyzRZLi0/2Xp1UhRLhMFfOJo3ZTRiElFtSC1U9xb7z
 NOeCSToXMEdBLWMSznSMQx3SVwpwr30T98dHODRqXEtoAIJAy012N13
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
(expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=y because
the invoked macro has a do-while-0 wrapper, and is not an expression.

   if (cond && (drm_dbg("expr-form"),1)) {
      ... do some more stuff
   }

Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
macros into expressions, by replacing the do-while-0s with a ({ })
wrapper.  In the common usage, the trailing ';' converts the
expression into a statement.

   drm_dbg("statement form");

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 027e96e0889b..3aa51e7f1938 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -224,24 +224,24 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
  * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
  */
-#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
 		__dynamic_dump_stack(id);			\
 	}							\
-} while (0)
+})
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
 				func, ##__VA_ARGS__)
 
-#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
+#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
 		__dynamic_dump_stack(id);				\
 	}								\
-} while (0)
+})
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)

-- 
2.54.0

