Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE443F20FA
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795214; cv=none; b=WbrW9k4IJdTdd4TvRYVxONiJHGvgP9WY2o/igxnbmNO2t/7uUiIUdAHtrkuVCanNZFWlBz+g21C2IzR611uQOoUE4wI4ePQuMtGQZaCjRUnZ9roGPizFxifIcb9NU5eoNILlGqgUQrE8MXunFRAsXwZqErO3L7NLLLAUL9+SICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795214; c=relaxed/simple;
	bh=1McoUymBymyISLFpJohX21UVwv2KSLo7NWLJUK7vCCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4Uu3pzfBj9nzgNefnXbNZ1wcjOznZr9m3Dtz5OQBvhxw8+gt1zWDhqE0+hHl1w42TR3CuBg4L8ON2WoltEMOLF6WwcwzAiAYxQW3bb9iVSV2n8FCeQPz8BehbcujkEA4Y6IK1Xf+nseN2bH439IShyx1RLoukyKiwEjAZgdJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdVF9C63; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdVF9C63"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so2324435e9.0
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795204; x=1785400004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlMszdZXGp83rqdq4F5705HBF23F8eoUUsJHW6GLZWI=;
        b=fdVF9C633PSDVPlg4QYFqjQZ1rhQg2Rb+PeHA/hn5Eqgj2jX1D0F1X29Z9S1LtxyF9
         RVlkkagYp6dkWNEJmDfGFefizkupkKAVbbJW0/ORbkXKr/J1ry9Vn4SBZoaSk52VTfi5
         HsUJ3xRHeHHbjXHU0JZ8qyWO7gxOydfTnpterguaqatwB3n2Tq8d5POKo7+miXzVG44H
         zTSpCadMyLYUzOzxQi3HzyZceGALi/p7hO6D9UnfZLbaz/6GrrzJ+u1eOGhxCvngLx4w
         Bn3Xdx4eCmLMZut2w9m1HHEwyd7mpMnDpeE5FYfVfAjY0fPqbeOkvMBZW4sFCKSnCUuZ
         IOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795204; x=1785400004;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlMszdZXGp83rqdq4F5705HBF23F8eoUUsJHW6GLZWI=;
        b=Jk8eOvqoWCm2Kn2n75Br49jlbxYYwgqoTNKunbZ3yKnuDjmU7BFYOLLFQvK0Fgb5hG
         TAFhb9YaaYawo0iQ4S58yYWvxAZIR0WijobtmeudwObkrfsPz6HLw0Gb1Q99egrMazJB
         MluU83TpD7APSFNnr/4IFkci0mgDsraVRI+gIpw40ygPcfn4wiyCU2WqsNSwa5Vi8IPJ
         GqSbCuQf5dK9f4esz8bQXJPa3MTzC/BUAy8jfxoEsr5vxFNJPAUK05a+YakqWuSfHGPO
         I4fykNnjd9hYf27rdPVpa/r9Cj2zWaavHeivjxb+Fyt6hfLZerNihTqWwZaOHwUVenBD
         jjxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3yS5do8dibih4XC7RbS3VLekcGcJVaBpDnlkTfS3PmjXq708+BzmGDSFRrxtMMS+dv0gCrILQyNIFbZUZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sQ2R/m6boN+mu81KIOHZpzoPeK1tLVNPkUdXY/5e+0y/aR0P
	OGv4xHti2+ObzKmFUHJ6NjTRcdqo7RQFUi+37ubR2GuGN6W03RjEW3oWLT/L0BP7+h+KFJTSG3T
	6a7EyzE0=
X-Gm-Gg: AR+sD11Ojr3bjzTmy7Vm92ZnZb1HQK+zbvu1wg/Dwg+kKvWda2jp/Nk6RupnznIz+FU
	gG2Xvq+WTA7wzBmjBI9oePE8OD6u+HY26FGXH5ZBADZY1wTzq8LEMjb2//ug2opJUsorZTAdF2f
	Dkp7+Vb4bf3B/GJp6D4xYuhD5dtxlvGECJUPjLknkSsNHhCGaS5plOcc4Wtlo4gwUCUmiyXD9K/
	JtTOrwqgPZRda2cI50kjhwQNvb5+DrAK17D3F1JZYaSSlu92A/HfEmWghnn/pnx2rnPhqnZRZGf
	5bCP2U5VOo5ndcrSZfpkDyo16JZ2rorCwys9LE7E0VxzRS3Zcx/NoN3n/1qXddvkysfIo2m4HGm
	NeItLXl1S3fODe/mhgEkKea1dCWnqCKqbhW31wbaEknDMYGkJ+bDAya66qfVbRJ9eYuLDw8TulQ
	==
X-Received: by 2002:a05:600c:19cc:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-49573c8c29amr21928245e9.2.1784795204083;
        Thu, 23 Jul 2026 01:26:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] module/dups: Use strcmp() to compare module names
Date: Thu, 23 Jul 2026 10:25:55 +0200
Message-ID: <20260723-module-stats-rcu-v2-5-bd582261fae3@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Use strcmp() instead of strlen()+memcmp() to compare module names in
kmod_dup_request_lookup(), since all strings are NUL-terminated.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 56d659f049c5..80e1638ac34a 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -72,11 +72,9 @@ static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
 	lockdep_assert_held(&kmod_dup_mutex);
 
 	list_for_each_entry(kmod_req, &dup_kmod_reqs, list) {
-		if (strlen(kmod_req->name) == strlen(module_name) &&
-		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
+		if (!strcmp(kmod_req->name, module_name))
 			return kmod_req;
-                }
-        }
+	}
 
 	return NULL;
 }

-- 
2.54.0
