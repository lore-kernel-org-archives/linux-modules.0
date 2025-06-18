Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111A2EA15C
	for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249686; cv=none; b=JzkvHs9czAyAz0zoRfGmUCzk+ntsLesB56t/oHV9lCFTg3VH8JJ+jbx2GCQ9tN999ZdQkwRdSVoh0ZrVJqsd/naoBjOSmgSJG+/Hpmsg09vsvbNP8bFTq/zB5OqidEJ/9LtuCieQNNEjvEZr3cTqYb7Uw6+CpayXECwcpp7TLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249686; c=relaxed/simple;
	bh=fgB3SFXePIjGAAroxOe7vGS4KLn1cXe8DO0bTA6QX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HA4Rnk7gXKWB3EmgSSt2x4elC0FQaE5D8m8C9rK54I5nbCTUvjD0mqRVTeziSacAVW6HtLVcvOye9FkB35LHihoBKU5xjoJrukuoR8XLMjApr/LAg9G32vPPvtWJMvjHLBBVCnsZAa+XQ5TWwOSxWUjGh2d98X3MiOhk1o2Snj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSIpCZ4f; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSIpCZ4f"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-45348bff79fso43468375e9.2
        for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750249683; x=1750854483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWLSglW/vLGj8eXXbGXUcYIDvRphlfSJ/V3wfszWlMk=;
        b=DSIpCZ4fuTXvpfpM84TxxcDn8DJtoaU65TgdBEQGtFS3eGP1dYG4OhaasxxQAopay2
         DALh6KoMJjI8t8vBAnzOU/orS3KrW5GG/HmTvKL0c37lvX9a396duvVgqrVB9pxFB1tz
         tOlUcHKf4lt6l5vD4eng7ACgxHDTHvnZtlS9LLVA40MATk+G37mZnwRCq6j197AWYvqZ
         ADrl5YZKhlCPBWS+eVOn1qKfi/lEeE7biMbim8IG8lNNoYDRsVnDtg6j+A4eta4JXXhh
         Hr1w+0XCYdh2dU21fuNlasdo25gTku4TzyXDVj2Fqk1bT5Sm1dUco2Z2cljuIs1UdCJf
         /8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249683; x=1750854483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWLSglW/vLGj8eXXbGXUcYIDvRphlfSJ/V3wfszWlMk=;
        b=rcWlzmfMb6NPCUc5Y7YMNPCFKFpNU9p+cSfJUIqmHYD8jxf06Q+9LA8NrGS1axlHs8
         JhSsygCEXLO/sjy2KsVHvzxz5oPbDrEkx9O5GqGPu5WMm/s00VzIMWtwG9Xf5rbyZUrr
         TE8v0gtKH7d352sGyIW74PU5SV1KgLESh0b3pmUl8aHFa07t8/IxJhXXu2oPjKQNoGqH
         Vyl+CpJeKoF7Aj7v1DF3wnnsSk0syMnu1dX4R3U7q6gkJWktOx/bXFR13IJUOnTc2P1t
         wSM+L3YAJ7OoeDDLu2/yV6oXi/EUCN6XY7atPxZrhYaIflQ0Ilb651ox/cHxtq1yZ0ax
         /rNQ==
X-Gm-Message-State: AOJu0Yy654msR8h4D3LxSbNrTBs/vn/2vaci9LVIfwyztfLx5tH00Yk/
	kJMyI1DgRA6DmA14udPxN5U4/ST/MB2UKWP71Wyj+4qdMhg4oHgQVEwmer5mzdmAfzU=
X-Gm-Gg: ASbGncu+TV8vZQsIjZUSCjusGGSSY1X0QoeSjGm8mkP+QZUfjYpNzIWFA9o4ykEcS5E
	Jiuhzi6nYOk+3PUz+qwX0tdJRWXlQJ535T1q3Vto8rPckGYcv5zRZTeya9YNVYeSo62V22GNP58
	DQsjeYI7/Kpc4xLhj3Ym7Tgu+8BQctPjSmkD1jqiQDYxdry4UbcXo8hHO7QzpKzSbp95ktrknKt
	Y2wJdJXhItfyVmRq9MXNSRvjUGe/q/TgXmd9mOAdkK6LZ3ZxvyNkF4n4dbLVt8VY7Y5sGIU2sVG
	XARzzHtI5tIfXtlZUGgtknenrbcSZxNL3UVvdkb9d0DJLQIBkyahXbIInaoigJ2p6LJ12qnd
X-Google-Smtp-Source: AGHT+IF3Vg0B1aNKfQZxxlZtQBuXdg9ogk2LLxujlUeKCK+DcZSTxVeNKBa4eTkeETtIQK2emq8GLg==
X-Received: by 2002:a05:600c:c168:b0:441:ac58:eb31 with SMTP id 5b1f17b1804b1-4535858a0cemr29514905e9.20.1750249682749;
        Wed, 18 Jun 2025 05:28:02 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm211215125e9.23.2025.06.18.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:28:02 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] module: Fix memory deallocation on error path in move_module()
Date: Wed, 18 Jun 2025 14:26:25 +0200
Message-ID: <20250618122730.51324-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is an actual fix. The second patch is a minor related
cleanup.

Changes since v1 [1]:
- Initialize t to MOD_MEM_NUM_TYPES in move_module(), instead of assigning
  the value later.
- Merge the definitions of the variables i and ret in move_module().

[1] https://lore.kernel.org/linux-modules/20250607161823.409691-1-petr.pavlu@suse.com/

Petr Pavlu (2):
  module: Fix memory deallocation on error path in move_module()
  module: Avoid unnecessary return value initialization in move_module()

 kernel/module/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)


base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
-- 
2.49.0

