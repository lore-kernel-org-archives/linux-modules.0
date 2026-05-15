Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E6F3D9DD6
	for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865638; cv=none; b=dXipREQi6lSBzfFXBHspDiCwuK+F4dmiaspAZUY3xOVbIad4yaLWa4ZSsX618QRFuJXvfieUflK3NKogTo33a281piCkLgX64dqA7+LZfXPLDTkVKNhFRuLDId8hjz7m+XWahmRCAxbSAkSknvgAhyT1xDH8DEYLhGrTzBYZWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865638; c=relaxed/simple;
	bh=WQzgbd4gD/OqB9V4Rk9Ji7gPHFa1NK2yJay10RsfNJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmPGanijIpHVsZpEVW3F6+0rOMaQBH4A9/y1Mb0YrBBHOe8ShTZP8mmHGiNeNvIQqp0mt4G+X40KuNs6x2NB6rKsZMZ/pBvsZVNKqJHbEZiMhJwhQWWAcsFuChX6tsNEt1QxHSFpMoQvF7ReAGKU1ZNxw8sogaIVwnTYcE26eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=JQCORrLj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="JQCORrLj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so408445e9.1
        for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1778865636; x=1779470436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qxFE8IaiHsbsErZJsCvFlpV3PqyMaRTCaZoT9JNhmY=;
        b=JQCORrLjMQqsMPtCm63xjtY3sJJNEjb1PoHFBOCak+RBo41a2s9Joo5m69UBRwaFNS
         nff6v0p1eEX3B6YAvFvC41Y1EdhM1iw6FWVyawLVTS9XSCrQWq51WAhFxt/Macx3cm9a
         wM7LQidJfcIY527eYi3e1EzIzesLELED0fhOCAwwPpFLQj0VyYmFxOEMgKr9TpBByPvO
         9/bR+S708z/82+st5xqXCN/dfOb3gf/HnXIWADHwuCyYsw57nvf7lGdpiUUiu3WPDL3f
         gKINpHbXWV/UVIudPfyxvJvE2ET8D5Q86qrNfqdjIKWeX0eNcV9J5bADJ96eQOKBMPNA
         n4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865636; x=1779470436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5qxFE8IaiHsbsErZJsCvFlpV3PqyMaRTCaZoT9JNhmY=;
        b=AUXKT0gMvDnNQMKfPc+kSTYJ6un/ZF8/qYwgrTeTVdPQ0lk/cX6/DBlipyMYBKTpYO
         hZKklI3GVv7ncLIATwJdwKvAMRtA3ZIclR2qKWH4SdMd/U73Ndu7o4Fh0dH7QNBpVJId
         aWRNd2RtloTex+kZjl/ghz5NVEIvPHhe8gozhRbztwwtG+4qo+LeZYo3XdShC6eU/s2p
         v6239C8/aFlefshFZzp0/leUqSx/5swotVjCr3Bdn5cmay6XVIrzYQTm4G0qMvAb4Pjt
         gHBqT3SHc41jZYopF+gCxbdeckkYcJK7j+0FxCrva/l69GxyBzr/x/+1yX9QPFVVVLdw
         fj9g==
X-Forwarded-Encrypted: i=1; AFNElJ8W4p8VjEo3a8azau/2JyH7xOR4lojJ40WttJ+CGUqiu4ob7JzJp4Ob8/jbO6GgfLz6CAAEyEmMjjCw7bXX@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGF3AbjDOdimSlOOh6RMEOAQ9rz48+0NFHxAI+UelEzKxBBy1
	akEqJeTemVd6Xno3w54SLhhZ/x25wURkzDGLpWhk0iNXhNyeUgwy7nGGIWY9W4NyYSQcoSi69uP
	lmKE=
X-Gm-Gg: Acq92OENGjBK0sLHxZlCDjrfBEikyaJ88l/oYL5xAnEEF62SL+Ns7BHPcdT0W+cAR1w
	KLpae8zT+tjOJhekBcbSFlJ7nkvHsLIxFWG7rg6vfmcuAdO+mzgxfOzu8xOub5JCqk7+jBazKLa
	tAgbMiLJxEm0VrU1dxGLInXf6He0eOBDHZatzfhbJA8scZHqbWBMLJYeapbFSPmNbiAPFh0XI6V
	8rt2+nGgAdqRyuuPHnTverRkQZ7JJHGvkcdUOUQNJvC2Ht5nt70IMCp8Vg5emS5rsojIUJe//5h
	U3gnUCsCQohooDlKvaiiza3mF2HkE4TKHe9ReuCpCTQDiNdIGw+7tN5GGf2AyTTZTMFkBE7KYXG
	3YR8aT8tVYrjP7EAkYaE7/nJfDtlQK5YwXCg7tu8yAhYThBaTFyumXuBSPMDYSrNPSVoMwfXNAv
	X8inbrST2MPVvPQQxm760zD3K9x4VtrZ/WJsSrLEc=
X-Received: by 2002:a05:600c:c173:b0:48f:e230:c3f8 with SMTP id 5b1f17b1804b1-48fe661b50amr72052485e9.30.1778865635735;
        Fri, 15 May 2026 10:20:35 -0700 (PDT)
Received: from [192.168.2.212] ([185.209.196.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm77251515e9.14.2026.05.15.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:20:35 -0700 (PDT)
From: Michal Gorlas <michal.gorlas@9elements.com>
Date: Fri, 15 May 2026 19:20:19 +0200
Subject: [PATCH 1/2] module: add CONFIG_MODULE_RESTRICT_AUTOLOAD
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
In-Reply-To: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Michal Gorlas <michal.gorlas@9elements.com>
X-Mailer: b4 0.15.0

Add CONFIG_MODULE_RESTRICT_AUTOLOAD and modrestrict parameter
documentation.

Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/module/Kconfig                           | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..1013104f0943 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4185,6 +4185,11 @@ Kernel parameters
 			For details see:
 			Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
 
+	modrestrict=<bool>
+			Control the restriction of module auto-loading to
+			CAP_SYS_ADMIN. If no <bool> value is specified, this
+			is set to the value of CONFIG_MODULE_RESTRICT_AUTOLOAD.
+
 	<module>.async_probe[=<bool>] [KNL]
 			If no <bool> value is specified or if the value
 			specified is not a valid <bool>, enable asynchronous
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 43b1bb01fd27..c9e01bb848c0 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -337,6 +337,21 @@ config MODULE_SIG_HASH
 
 endif # MODULE_SIG || IMA_APPRAISE_MODSIG
 
+config MODULE_RESTRICT_AUTOLOAD
+	bool "Restrict module auto-loading to privileged users"
+	default n
+	help
+	  Restrict module auto-loading in response to use of some feature
+	  implemented by an unloaded module to CAP_SYS_ADMIN. Enabling this
+	  option helps reducing the attack surface where unprivileged users
+	  can abuse auto-loading to cause a vulnerable module to load that is
+	  then exploited.
+
+	  Note that this option also prevents a benign use of auto-loading for
+	  a non-root users. Thus if enabled, the root user should execute
+	  modprobe manually if needed, or add the module to the list of modules
+	  loaded at the boot by modifying init scripts.
+
 config MODULE_COMPRESS
 	bool "Module compression"
 	help

-- 
2.54.0

