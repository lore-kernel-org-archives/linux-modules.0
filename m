Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6B29D292;
	Fri, 29 Aug 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457387; cv=none; b=gyC/NA+62RVwPXIGCzn3IIn0BScwWebfOxcPi6c8jfw97O3XnkQUAO1OBVSTC7XV6vJ0Cw+P/QgS76X+TJO0J0pnq2nhGbTYMVDYBwmSCNcJaajJIdaOzUwc3tB+H1iyIDlFyWObzbCdsufWb/4V2Y9WZ3rt7SLEM+NxxvVFnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457387; c=relaxed/simple;
	bh=JbhnwTVYbBKZ246Z3oNAI4358vS7U8t38pnsI6lRz6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9FV1kDurCmv3L9KDd4nvCoPTl1sYmd8kr2MtEQl5ZtWp3QG2REs3NzYnhBJHls7wXfGtLr392qYQIXaxkIDT+NgsMWcHX4C5Qmnv3EA2AXE2t/LzsGmefYBuhV0XGDLg5nm4Yt7pC+i7IJgdko682xs9vAYX671HEIcVOsOewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIQJzK7p; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIQJzK7p"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b471737b347so1259223a12.1;
        Fri, 29 Aug 2025 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756457385; x=1757062185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbSLf0FRmNd2abuQvWD3Rx+FdoZAzEBxPczsZ+T05a8=;
        b=gIQJzK7piwRhLRmIyXBzM7L5x4gGXMpTJiYBhdDG2qkMHK2vCkU/Fj06Fk984frCMs
         8XlQhY8MimLNPa/5CNFGQ8kMraf0PQJlKryq31Hk/fn5ZEvXWgkYH8rPkFjcWQkHNwVV
         OVJ5WF94SalozfzPk15XoVGtl7/WsxH654kuqsrl/S2gaKuYuC8ylCJI15Efq+w5WVww
         3qtbs4kQ/pQ9VE6+VMFOpLqQOpw16dN3/Mzw3pQV3RQDCApaLjbFX7iTbne1SHykHjRZ
         7WO6UJks1HlC647xZ8KVFiSWxo+Ko3xMLukXWkNrv/TsQ3Jv/gSWNO3jr4YtXvw8/xzA
         bTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457385; x=1757062185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbSLf0FRmNd2abuQvWD3Rx+FdoZAzEBxPczsZ+T05a8=;
        b=FHIDer0EVw4QP99mrW/V8VUahPOOA8gz8bY9TIfzr3ST1uni6upxPBguUujs+NSi4k
         XRxuXYlGJwvzBx9cse1MfDOJDiJxCb5j4pFeL58SD1tcmIhHxjvPHO/Pv7NcEW8YfQxU
         gzZ/cZfTbO2DIsZtkf5XZg1BQxx2yk7hZOHFZJ+RsNXr6OWk9JSJcgA5/VeR5tsfH4Mb
         fKD+FUhQ+z/p5towJ1MSQt1nziMjkG9iduiQ+hVNOuWkhEHZnxhgPd6PWRXshGUj0ZTi
         OeJP2v58QsItu26n1AZZc13TEL9neKgIZKDPP/oz9JQNTihnLPv7QkEeFHC94z0+rw93
         Fh1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC3fGim4XIIHDQGdwbd8tKKmA3MCOysXae4u95WhtvtHLesfWEvteBSoPAXImVJUXlSvX7rBHeIfbYKNzZwA==@vger.kernel.org, AJvYcCWTx3HDGXqlCNCiynP2JnqU7OsfdnkNCP79KsRGFrZZ6sfRvu3wWQLp47bNoXkS1IM2h2A6sX4Xm3ehc48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oBh13M42pGwPCWlSRs6IS9kwm0M5c/5uETuzL1ARvpbrP530
	0wt4kNHk51khyGX0xZ7lRNOuWVGlWZeF6hVJysenGkvl30Yf958xcoiU
X-Gm-Gg: ASbGncvCzTRxGtfLY78672S4EjIz+AepPStSgF2o2sQM7i81cdyuayntBPAniWLxfni
	JpwJA9xUe1b19Iw31PyjuJEMRwf/WGXWvIsfUKbMoyjSdbPtaRin07fh+EQCGudKbl5oTbPyuWn
	ovENdYXynlmj5KuxkLSeYMZmZmIUcetp2Wih8/II3rgpBBygZfw+MNX7LPN2mPBGAuM1M4qgmi0
	7w9Cthg0RpjUssk5xLmY1k3Yry+aF7pSex+VJutZqVCZXzRFYJoltgNePAe4UX9yfothl+j8w65
	Jw5SckJbNCzGS/dUvSQjP+avMZIWVCsk3ZKr9yDHAy5eaJk86O/uC+ywcD7t5iir6WVs2PUexNb
	uWeVphHSRlYdc1ByN9/ROxeSmIIQaoAsRswjujkuIH3Mi0F37Q7uS3gPRD2ZJ
X-Google-Smtp-Source: AGHT+IGtL08S6syuCjaCCp2xwbcRHO5VB6A44I8SoMoGAcrIf5/GzAF9mgZXy9yw4UT3fXKyFKOmSw==
X-Received: by 2002:a17:903:38cf:b0:240:9dd8:219b with SMTP id d9443c01a7336-2462ef99b9amr367370055ad.49.1756457384920;
        Fri, 29 Aug 2025 01:49:44 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702980sm18561865ad.13.2025.08.29.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:49:44 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 0/4] module: logging and code improvements
Date: Fri, 29 Aug 2025 16:49:09 +0800
Message-ID: <20250829084927.156676-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches cleans up and refactors the kernel's module loading
code. The goal is to make the subsystem's logging clearer and its internal
logic more straightforward for developers to understand.

The patches in this series: 

- module: signing: Use pr_err for signature rejection
  Makes module signature rejection messages more visible.
- module: show why force load fails 
  Adds a reason to the error message when force loading is disabled.
- module: centralize no-versions force load check
  Refactors the code to centralize the "no versions" force load check.
- module: separate vermagic and livepatch checks
  Improves code organization by separating vermagic and livepatch checks.

---
Changes from v2:
- show mod->name in try_to_force_load
- fix a introduced bug in patch 3

Changes from v1:
- A patch was dropped because it was based on a misunderstanding
  of the ignore versioning flag's original intent.

v2:
https://lore.kernel.org/all/20250825091545.18607-1-wangjinchao600@gmail.com/

v1 :
https://lore.kernel.org/all/20250822125454.1287066-1-wangjinchao600@gmail.com

Jinchao Wang (4):
  module: signing: Use pr_err for signature rejection
  module: show why force load fails
  module: centralize no-versions force load check
  module: separate vermagic and livepatch checks

 kernel/module/main.c    | 14 ++++++++------
 kernel/module/signing.c |  2 +-
 kernel/module/version.c | 10 ++++++++--
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.43.0

