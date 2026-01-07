Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F70329E5A
	for <linux-modules@vger.kernel.org>; Wed,  7 Jan 2026 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788655; cv=none; b=SHvYNR9gITc5jEsD+DzspqqoC2i3PKcKpa31vzibvpDdCGoThYL52Z/87mszfW0KxjVqK5H+VVoaAegCy1qvAe/KZRL/MyryE8xkbT1qgW+5HNaEzGeQJTNIwjTtCOCzIkXk4NNccQq9n+gclatq9Iykmj0TrpMQKaHRmYKxhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788655; c=relaxed/simple;
	bh=s5gtHosk0WX7KEYnl6eaZ3wvb1CKwcyuhMiXSkV3WeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnkV0PLGqLnP/cOM4TH7sjeXIqrkxLDxbHwrgYbDgST2th9soqBl6NaoFslL/BNY4T+9CMiIgYk1clSCpxEKCq5l7kHZBlbi5TCgGRTul676mzGST1FbEiXuNA7stsU8zRUvckE6QiL0iU0o13LhGwQwL1xQuJmKWcEk7TCRSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=abRL/f6Z; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="abRL/f6Z"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso19223355e9.3
        for <linux-modules@vger.kernel.org>; Wed, 07 Jan 2026 04:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767788652; x=1768393452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpSWjoueUhBb14aD8RrMxMLp3NlnjMNn1484M381QDk=;
        b=abRL/f6ZJX0rSJPNch0HoRvOywwQ2ocFzTrUW6L6x+ioXwNn8kDWZ1iB4Fkte8oWHw
         6utIOK8wfS/XO2QnfLyzTZGIggGUv53+wNOGI3lSf9unaEoVr0iHNbC7u4NQYg5TUWKn
         E7aQxRZ6FPotRh7gNAYbu7XSGtIVTPsW6dhcEcRiw7h17fcYQ68aZsoI0SsMwHg+l8Kb
         CagT75+eD9kRg6vogb3gA7Uhqz3A7VIWe/Y7IMybdCHR/japxjpcCWbsql/0bn1yzYvf
         9p48Yg459Mkxdb5J+sNMlH5QTw2yI6Gv1gB5/MWa5j2RzkkQeX8ueOSUE05Gbo+Zsvz1
         9pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788652; x=1768393452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpSWjoueUhBb14aD8RrMxMLp3NlnjMNn1484M381QDk=;
        b=chtibhpguHfYFXDgFlDBilzeBImfqgIw7Y31OD7vLkWQfSXvPDiLqDuIqqE9zn3P3n
         XYe0FhpeMe0hCZSkstSRjeYcRAuYYYW+yrBfbiA3SfMvKYYRgrLXlqUdGHqq9Y+MgBnr
         lC2baFkXq0b8iyQTYNEJYdmVgMVcCsHvWG3Nw5EDqZCGdNGBqATAiEmDQg1fYWgZu1Hn
         emFJDE9o4X+qcaZ93QanpxeX03m95X7GHHcBG+z1dLwjC9/+e9vYDds6+L4w3h31dcD6
         IWQ5MVQxdgn2qkeHcn+BuvbqgGytM/L06hQbTFKdnvbEguGxQRcaaavUXtrA6tsPmkX7
         54Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXyujGD1FLvtuDhFVWlC07zKOVJK1sEy1OYO51xu39ZjDiHRGo5F3A500+ZdNAR1ghfF8OKOZd76tFavCMo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46EG7O37UCSwgBxHm1MG+yTOLv0StaRn0XbYkRRS8fYWMOpiu
	Fn10GISqT1mxfQySCgXNJaZdmNRlI106mL3GlDwg3fquD2XiD7+S3HHYfPZKqqrQja8=
X-Gm-Gg: AY/fxX44hhouQGKqbGo1eZzZUnxnhJHH2tHSkWDnEB+d/Yt+4oGH1HMTRSGaUzL1OYu
	neh1QNTS8x6PnqoBd2f65RfWcAXol8yElzanuc1UHwwk2fHdGfWLiAves1+6ip+ww3djJgxwXdJ
	cBnWMZDvHluXKjN+jyGjbboSyNm2oT1fUpFkIqKjL+wOoxg0D8DObvfEXqq82LcL/y9WSTTJPBy
	ijSDXl1n77OZVdMiD2PKgS2gJpfFD92DKvewQ5I7PiaDn/GG/RH4j2tbbY4kEq6OPJeNJc7YzqX
	2sYaEtaOL5TQQIdQg26SI0yBXvBVP5XLkJiLCuYhA2MqsZ7LGBfamf030R+GSneDq92lt/65ZCv
	rAxUzsQN4mtioocDcPtgS8jlnIxT0qdpDxrt014mBlS9ARBs7gG9IfJiRt+MPpYs7Iz76nUZe/X
	0EAPrq0T3HG2b1anwOHjEFR5+FCuZ8nMg=
X-Google-Smtp-Source: AGHT+IGgIvSdtiQVbxb9crIhzsFQqS8uYB8K9J1AwrgyVMxPpdtVjQLuJ/AgUZQb7Qyd1ju2bU2yFg==
X-Received: by 2002:a05:600c:1392:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-47d84b3b724mr27671415e9.30.1767788651833;
        Wed, 07 Jan 2026 04:24:11 -0800 (PST)
Received: from zovi.suse.cz (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm97977945e9.7.2026.01.07.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:24:11 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Song Liu <song@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove duplicate freeing of lockdep classes
Date: Wed,  7 Jan 2026 13:22:57 +0100
Message-ID: <20260107122329.1324707-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error path of load_module(), under the free_module label, the
code calls lockdep_free_key_range() to release lock classes associated
with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
subsequently invokes module_deallocate().

Since commit ac3b43283923 ("module: replace module_layout with
module_memory"), the module_deallocate() function calls free_mod_mem(),
which releases the lock classes as well and considers all module
regions.

Attempting to free these classes twice is unnecessary. Remove the
redundant code in load_module().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..bcd259505c8b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3544,12 +3544,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	mod_stat_bump_invalid(info, flags);
-	/* Free lock-classes; relies on the preceding sync_rcu() */
-	for_class_mod_mem_type(type, core_data) {
-		lockdep_free_key_range(mod->mem[type].base,
-				       mod->mem[type].size);
-	}
-
 	module_memory_restore_rox(mod);
 	module_deallocate(mod, info);
  free_copy:

base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
-- 
2.52.0

