Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE82EA163
	for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249688; cv=none; b=BLaXk6zj971RIo7xo1IBQHyCiaW0h/sz18rBBfzJFceiRTQPXzmMkT9nni/MrWn28XlGUIx1AveC20EtdclxJav959y+3uootT9T3wP2FjMMBxXGT5wnecuEZ0tyrWZXkrD3x5Jeq1T/+BWUZ1Dr581e4QnosEe3eqGsekI4BhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249688; c=relaxed/simple;
	bh=sJFwL2wUca0QYwD8Pj9OIydWF7+2FJd07aMaOq8ap9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfR9j4B0fK12TDI8gIuIIuUWJTRncDP1VyblmKIi30nZubyQsRZh+3WfUozv5lD1vkwtQNa+XbQJXa3pYK7bNEBRfwdjer6RDmlgSAwQoGmrtRweSdxlq6tWwFmhlkn2h2puoruL3Zd8DA/Eu0SuoTSAwL1MelFqNIuotiOia5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fDVkYnnc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fDVkYnnc"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1361472f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750249684; x=1750854484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRM2k4b/KnNzcC5gORTj3uJESJo1D4SQEzR4jn8n2v8=;
        b=fDVkYnnc/pfSGlbh0ngllTQbfwPijtUnj8p271zkeBEiU7E0LEzXgV4okXbGM+teD/
         hMUjYeGAlko64xAHUoCHbxaYs3QPm+Hr1LnZHJcPsRsn0kNCn6QLeBiXDXxtMRRCb36+
         7Ptm4mzcAhLKbWRyg+O0wUUpi3CGdxRn0YUGA70AWH7FNJq1GlqLxLva1959LAufsg2M
         EHFgfgFfS4gD5PU/aKcOxPnVaZ0WSFfj6paDTmZ92+AZvyG3aX04n0pRXNQi9G4PZgtc
         /0BlkgagUQXRyxjWyBYhOVQCga8KmTmKyazItENRMQXdMfSWvzb/snL+R2EEe1Cd3w4M
         fhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249684; x=1750854484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRM2k4b/KnNzcC5gORTj3uJESJo1D4SQEzR4jn8n2v8=;
        b=ou5LXqUavl+FP/CKttlZr3Fp8JZKKOBoPdwpLRdZoZNri0qONrO8kqqYZQvM6RtM1k
         cqCJEWE5XXDvNu4xtQYzjdYoOmP8T/S/PduZSzUksykvA7vHA7W7nnU5KLXjvUlhneKV
         i+qU4bac9of4ku8I5rcEj0Z6+7jvvq3GPEo0mdBP+MSqgrWGhbqpulQNsIwLn7aAafXv
         o3f5vCwhtn+geLrcC3P7DWh6RxXjnxKkkZYS9WTiCcOAkbAKWlsWp9SxbYzOUUGtgTp/
         Miar3O4W6/JOEsT9m5109DT/2MsJzy7Um/7kQkhVAwI+9NkgcOeba0e0sEg8/h9aAZTJ
         dlJg==
X-Gm-Message-State: AOJu0YwP0brZRYFq/Bt0l54ga6V+5kughsd6u3LEfNBa5Go9iYIYvuMK
	pC+a69aXwhAKH7Edehe5BnUsEYq4vnPWYnChVkphLVzjwwWBn2O/UPmX/EKdXUgOE0g=
X-Gm-Gg: ASbGncugn8u1vtAfH4BKHkNRUCyYRG7EPNAqNMpvkyMbttKDvILzxJ5TQmE/NokchoE
	Lw2pVa0fRUsw9z2qEia2Zy10G3UpLZba+NYQxmjXUmuOGU+qdtS6bbAtQLQjJceZlIwZ+AzIuXb
	ggreEqVm0tlk0LrBC2uOpQIESpvMgLhz5E0U1/lpsQMyw+WJzgWhecj4irh7SHJqPDJxASwvAV0
	whNPlv1+FAf656Z8Uiuh5FXshDS/8seddGVW0C8eOHvK3dWaFrXCgimGIRu49LsqCVlAv04W5hb
	7T41s3bLrtlPEx4L5BEmaNNta2N8DO0gwkL7C+4MVBdvkp7LbYluWk4xopUUZw==
X-Google-Smtp-Source: AGHT+IH4wVSBvwNbg/+cKiE2lTnfF+YpA69MTC2nxpQFt2JGNdEN+L/IvpFGedjfc/H5h/HkCtSvgA==
X-Received: by 2002:a05:6000:230e:b0:3a4:ebc4:45a4 with SMTP id ffacd0b85a97d-3a572398fbbmr14222009f8f.5.1750249684002;
        Wed, 18 Jun 2025 05:28:04 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm211215125e9.23.2025.06.18.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:28:03 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] module: Avoid unnecessary return value initialization in move_module()
Date: Wed, 18 Jun 2025 14:26:27 +0200
Message-ID: <20250618122730.51324-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618122730.51324-1-petr.pavlu@suse.com>
References: <20250618122730.51324-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All error conditions in move_module() set the return value by updating the
ret variable. Therefore, it is not necessary to the initialize the variable
when declaring it.

Remove the unnecessary initialization.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 9ac994b2f354..7822b91fca6b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2696,9 +2696,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 static int move_module(struct module *mod, struct load_info *info)
 {
-	int i;
+	int i, ret;
 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
-	int ret = -ENOMEM;
 	bool codetag_section_found = false;
 
 	for_each_mod_mem_type(type) {
-- 
2.49.0

