Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B4407CF3
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571124; cv=none; b=eDmTmVedIzflRCmjcsdiEchhfhw/rJfu4VGdTR6Ktwghv29m9JXgXr+LFSW/huIw1qyAr74wekSQxqkfadQIDjMDw1bxcLSCfh8GL177228sIoVgQxVLUqnY7FyNuEBrFufCo/dEMyTkItG8k8kOb/uDXqMXNtwLgmcK2edilLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571124; c=relaxed/simple;
	bh=REwTOOE1mqMqnddUkra1IfxtRUe/yNV2svctK+mV5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FH6F4C8bmxu9cCFrundkN2UYCkJj6ns8lL1s7sicEcPP1T+WYVycdxZBiYgHaZdQtuAr4rM1EPBp6qkCzpNop2VNcbAl2qvpNsGbBDP9q+M1nGkeIdQXR9CJY6Ipz8oOTDl9eNYX9dzkilLKnmerngc00crIFesAOofqgCKCMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ghH6dyWn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ghH6dyWn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b613a17bso5537435e9.3
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780571121; x=1781175921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55n4rsYAXjvxgbCTrSptU50r7Jrqb08R8hB5CV1Nz08=;
        b=ghH6dyWntZWPjCfA53iD9T1u/tfq3KJsV9hUSYXINjYpbMZM/CgmLi6ymJ332VrTHY
         RlcCqnDE3n4peTKXa/inZ71U93VfUFuqrlox60dR8tbE1AIhGVC4vvGVtbCQB9kDdTAd
         WJ2qoG5WudzxAEcZs6xl6OUWsZZw5lN+8LA7TvvWfJmlDayuCuuqLuiX2/DBmD1C24AP
         I5qkjLi5yu8EcCNgP0AMdB9JpeypoLM+EjrGRELKTQ1Yn6RHfz0XazcE4uHllnSooo5g
         xl5mldlf4V0M59zFZlKPUtFWY4XuPjq8HFhIc3IbX/i0llpXcqBHnmbdEszMs/MbtCob
         ROlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571121; x=1781175921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55n4rsYAXjvxgbCTrSptU50r7Jrqb08R8hB5CV1Nz08=;
        b=Y3vqnqdQm0JXXysQf/gRCO46yKR9Mj9Cwh/GT8kQqi81OROlVIG8gDNIUEoVzdYFnH
         78BhC/GFY+Q6M5jDkUO/2kLpHafYceV46DLaG5Aqu56RjdQctKlsXoRETch/micLkD8u
         wgm4udbEURPxxjTCKlzhLs5V1CAlty4wTbGNMZ8VvhCPmQ8/nJUcIr8+XcROP9L4Fgiu
         Yrk2q1hWU7vEcgRbwVgkbOW0mF7jhMIGbj0n1hdlGqTHHGRC3TBx+rh22iqmaY2MDKnv
         kaDtLh2yufKl2DTcbqOQBim22q5kEAt4vOWt+c5H5H6thUbSOkPWg8XkEfSjowOdfwqE
         IdqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Mn6M0u6L/TcZq9gmyYC0TcvP1yRdGKTcJhGk9GVkm79N4vr43aX/1SHHqcvD+OkUrI3nBWmAwos1UhGD0@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMp8rqDZY8eWHxMg3CpXgTZFMs+xrVisVAExvTcUEzGWT8fZZ
	R34ot2ry7EgcF7YvEb5ZFajafFyV0ciVvTmHlIuEOpaq7Wd0uzl8dB6Cw/Xuex58Rj8=
X-Gm-Gg: Acq92OG95tIE3GovrcR3ZFCIwRsNC6XRqarBo+PdtO8gQo3tl70SimrByDGaJLq5iKe
	KlTilEAOQqPaPyv6qyy9/FilNb+Chf7PXQP1Q3odmllQ7DZR8rB5sofNzsAjtJpQzkMysl1fl8S
	d30ml0R6VN4WwaNw7GFPj1pkeaeorv7lrvTsVrKxDfY+zV4EhvafWL0FGbmVYjmObr2GA5qkAm2
	oV6AK9Xm0cXdqo6ykapoxcWhd9Cjs3J+qFL++b3awXzfuchFael2qHTP71LaDLx9oFLgyA+Z6mS
	NU9377Gimbq/Bld5jI45YP5yoQzb+Hr8KIZlrB5QeXfZkujYnwDvHjtH/J4xnDBKYI9uJQs7Uey
	o4xKOZEroLVMqI6tRQzq8T621Qxqcwqk/WPcwOxPnKnxHEQzm7kCjTadhC7e/uCggxyuU2Mu8aL
	L6tontH97mnb8Y4l/gi+vq0Ihp15AEdtA7iQum/zs5JdGXGxmREH8lbmkfkmp/Bu5mE8E+9yDWb
	jixjZJgpCWM8a24FnKyjaNaWCYZUuEYfkw=
X-Received: by 2002:a05:600c:630f:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490b60e41a8mr126922655e9.32.1780571120997;
        Thu, 04 Jun 2026 04:05:20 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a273e3sm99648235e9.0.2026.06.04.04.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:05:20 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Matthew Wood <thepacketgeek@gmail.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] module: Remove unnecessary module::args
Date: Thu,  4 Jun 2026 13:04:44 +0200
Message-ID: <20260604110455.1608038-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, various parameter-handling code kept pointers into
module::args, most notably the charp support. However, in 2009,
commit e180a6b7759a ("param: fix charp parameters set via sysfs") changed
charp parameters to kstrdup() the input string as well. As a result,
module::args now mostly wastes memory.

Reviewing all kernel_param_ops and module_param_call instances shows that
the last code still relying on module::args remaining valid for the
module's lifetime is simdisk_param_ops_filename. Update it to use kstrdup()
and then remove module::args.

Petr Pavlu (2):
  xtensa/simdisk: Avoid referring to module::args
  module: Remove unnecessary module::args

 arch/xtensa/platforms/iss/simdisk.c | 38 +++++++++++++++++++++++++----
 include/linux/module.h              |  4 ---
 kernel/module/main.c                | 15 ++++++------
 3 files changed, 41 insertions(+), 16 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

