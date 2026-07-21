Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515D439908
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667440; cv=none; b=Rw8CAo0Hp6a0K657csvLCf25wXLSe8qVz0NdA3wICO9e3bYsR9hYnIgtJKqUV/PpybMyqeR/QhuchU3cn2DieEHPnRHBkZbezuuivwiGsUzNyRNiYvg61NZFQ94pL3Tq/A7jhcPGxnbo+iquSSKO8pEdult94CHyRdxW/o8LlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667440; c=relaxed/simple;
	bh=krCb8u5AazdMsEF9z+e+5QeJqi85jxNa/cGvt6tyuY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMxlfM3qnVZMifu9l3hKp0dG49Oz9m/bgU8GDag2Lwh8hOKvOZaiEGwqT64Fj3KpeS3fj3WcdiNhQRGCL+qrp+l9HhjrpkYT8fF83ff64OltB2hurXRC7h9xnCned++Cb23Zip0lq+9E8fUxn3qV0MYQ85DJLCSSVN8EK2zV3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGsA3j3F; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGsA3j3F"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a377223171so5776591eaf.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667436; x=1785272236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T319eudiwbUhIX801T9R3taNsc3hT1nhhg5oWUNGgcw=;
        b=mGsA3j3FH39ACXBT3416tVAp0esh19rrTZG2S6eqaNw1V0ig97hwwNGeFeiIA2U3cl
         KYVNTAwqE933qnSvxjmX5dcpi3CvWCeFOu2YZZJ+7MUqQj8t/N0dexhmBJsoYyH5K8Tt
         Pml1ojwnGeFidqcapO+N336jT7HnHIsdYsjT8boDLJVGRdarq/RLO4lcTMaC+RdDK/FZ
         YIJH6/BlDYrVORAQNz8gwZwM3RDojwxRbkHRAEEIosLl4qYn1tImFA7LbFk4azHd24fL
         hYeRkwhgZHi/movrcRWs8c8vIw1nvh3OzQuhdOy/rmMeJZsLGv1AxqRgpJy69FPKHhtc
         yP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667436; x=1785272236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T319eudiwbUhIX801T9R3taNsc3hT1nhhg5oWUNGgcw=;
        b=mVe/eHlbdR1SMq08zZhnUbIAyZHqjZQqiOfaDw2rWYPHtgzmVtUwkqpLQJ/WTudFti
         0FX95kf/NgXwO3XMKuQrhAzGDOKHB0kljNPxFf3wcCSXElCrao48wpal3huX5zsyZNAi
         jc9F+GFU4BxpP7krqYTbYTLrZ+MVm1SY1mMcAthr6GZ7MAneP1ydS/6HRZx+y2P958rn
         vTxoTASs9x7gPkgKXbKyZ0Miuf20edNfoBnvBlgIDQP5Uag3zZ+XIO6zNb21MSesImVG
         gLzhVMLC4wba70VieeMym4YiDgmvhSGgGONMosgpo2dIMUsWwH6Mi4iAC1TWnyCL0KWx
         S7Sg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+QC2gALJMpDkZ/3MFIFZft9eIV1NcP07woiZQS98pJY3SoawzsEiH3NY+VOY6N9ObjuvZlLSYoSRnUHtu@vger.kernel.org
X-Gm-Message-State: AOJu0YwXe4NyF65RghMnW7BSiOFGdizsfkd5rU23vlkf/OgDKMpUsJ2y
	11wBrzZsJNHdZ/C711MstEZ93J6594O3bh/0UmHa+LqcRgxlE6z1ioe8ULDMtw==
X-Gm-Gg: AfdE7ckf/1UWa7q6XhLKWUFXG/ewGuLNP1rKYM105+laBmtsJEfuQpRICBqKrMHQEnC
	xz3s1ewjIMT7FC1Qdln3cHQFDeCfnvd2Ae79ipYNZUYlT16GVybAr/eVCc8iLb02cwc2zyHyoPt
	mee/YVSD2PFv+6TiJowHaJP7JNmAMNwUnxe89U/AaZ1zxYVq0gfpMuxj5mTIFIf1+oqZtPMnppC
	vz/Wb2Ig1t+r8lCO/Abau226hz1kp6SnDvt+HTbSLnwEibDf5G/hUXYUZOrfE1DfExtLGYi84Kw
	ssN0SgKMbCKCe08C8/bMbeOJBFEH3I/tsEd2cj/LusWfExevZwQuFI7eQemFEqbElZLwJ9qfx+2
	3HD412m/5ppgQo8GkvTGL8nEayYI07FktXOaZqjqbZqgOiR3A8ODWQwnF98+Kz/jYFSEPWJQxPg
	eg/d0Jz66z6E7/9SJX719nd4sAQ4TVf9BWyUSfljQKVnw+SP9svWNCT+yig02+wr8aKDj9ZvvIR
	2HUbl3HT+Ld9cgt7hhqPdQwGA==
X-Received: by 2002:a05:6820:6ae4:b0:6aa:9be1:4844 with SMTP id 006d021491bc7-6aa9be14d0bmr55047eaf.5.1784667436247;
        Tue, 21 Jul 2026 13:57:16 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:56:53 -0600
Subject: [PATCH v7 04/29] drm: fix config dependent unused variable
 warning.
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-4-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1088;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=krCb8u5AazdMsEF9z+e+5QeJqi85jxNa/cGvt6tyuY0=;
 b=4M1ooBzHTgHpKgFhIU2vZ89NHilgFq/cQh/hvWXLai2vEDkjLvu3XSirc+eK0dRZWMohPAFVL
 Zfn8h9XTG/6CWHI77V78nTlSjqAbqe9MSXYq7/3dAJFbL+3xt8Yvtzu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

__drm_printfn_dbg() does
  int category = p->category;
then does:
  if (drm_debug_enabled(category))

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, that macro doesn't reference the
category arg, because its optimized away, as not needed when dyndbg's
static-key is under the callsite.  Silence the warning by passing
p->category directly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..ac0288dabfc0 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -216,9 +216,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);

-- 
2.55.0

