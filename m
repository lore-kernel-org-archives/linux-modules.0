Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27625A64C
	for <linux-modules@vger.kernel.org>; Sun, 26 Jan 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900353; cv=none; b=E2Mvtjj3YO3HXyGkgE+XqCmVBeo5tK1yfffdOsn0Vw/b9Pk8SPwsBhzYgQM+/gLuch45z17klNBosmOS3+WWZCY6zr9V6LWgPF76A9mQ1BBbKPnaRlUx09d+5/qu75zKjILS5NEeWWNKyNtE5yHn5ntfYHzZg2u/ovEq+J8pkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900353; c=relaxed/simple;
	bh=VeGKqeZRNUiGBZptHO82aGCk8iJCbxKH7yjOtfrAbjQ=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=idKP8xarDEpKtNybVkmavln6mS8u5ua85Z5s0sSHLFZDo2zuVNrkzKugNRNuv3CefihlmdjmkL71c46iopf4EU7nnAZLqbnsXvN+tKm/4j9PdEicmdlOLfiv8HL84KEGr0BIJroVQrj2el9DmD3Cb9U8uDHmEWp45xPPFWKMzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d56Ytk/P; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d56Ytk/P"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeec07b705so698486166b.2
        for <linux-modules@vger.kernel.org>; Sun, 26 Jan 2025 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737900349; x=1738505149; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:cc:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIMpI9niSwYkKq8Sii2/yjyhHylHAR0sOHgf2qaCK7w=;
        b=d56Ytk/PH2zuXOgyYaBh6OT2SyiEOhVojgbuaFuFdu+MnSzk+RvetsjUY5g2I78sZW
         nWo3A5MvRHJz2wO9oDuHplthDVCgGxFsfWCp8TOeZK/7fOBxbiEcfNzYrVWBTBPWQtxV
         VMlFXwmEv/7UzNm4Ri9Vx7D45CcDGnCUAmsx7Za4C2+1hMMGOEb1s+eojIfMcDlb28Nz
         WT820c4o5zt9jy7RwIlnmomd42w2t4/aZYj7xe8xC2iWgqEewym4izWX168vB95jWDsO
         w/rRQhao8+fGfDYRziAb5DxcP/gxWO4MDtBKj+aFTz1VFUBVyCN1//6hRUOTakSZzz6d
         6BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900349; x=1738505149;
        h=content-transfer-encoding:to:subject:from:cc:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xIMpI9niSwYkKq8Sii2/yjyhHylHAR0sOHgf2qaCK7w=;
        b=Y3MhgF/WsfhY2vBSlF5aw8eucfQOyzJA/MWyki7FUT0nM1n6gYVC6GXEQpg7oQz14K
         1038KlNiUDcyvTCBcAt6//xP57yxvchISMZJDMsQubCZXrZNBCtOSAQI1nvC+kVm3TDr
         wRwuh/H8eWgjYY+bRLy3mTi+0Co5g79C6vGr7AwTv/lXsoAcxBG3kQoq+EgQMTXOu5yR
         uUHcgmhI0PfgX5EgoM4tRvrU2l2qytX3GF9mVg1RFtpW3F6HDAL+TMLvgWYrmRccw7Um
         GgVbE+ALNkcMCZYNEINr32LwLqkxVbWZcH0HzVxhnAm5Oh8y81Guyd5PltSkgouvBSg5
         t6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsEu4BsNHkHK8KccF00Qllrna8KhOS+JEJqeriv/ZTB7fAkfgi91ERdXCSayWxHzylQND8mRrI3tyJm27D@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwopt3Q8MVvAZq4a239ELQytMoWbdI138tLK8duGCbv4FZmnTk
	h1umREXUXs+ZT4I40jwRidYpRmwU1bzymVk4o12snGfY4voWM27FOm4qg+DhD+A=
X-Gm-Gg: ASbGncs89wKQwks128FokxWZ+ZBeE7/7YFt8F0VPOGhMGJ1eCcQJwU1DwN9aMrm9TdX
	8XbujdYrBLgj0RVGz6i+9nFIp+yFle7xWiVOT/JETbjiUIh8TxMoJXAixDKbCdfxpdXgkitbuna
	u+7fGTyyKxG9hPX4MdEea9vJYZ9O+KaRKxunK61sY+/GnOOeg4Gj7gmQ1VE4O7FU2bZKBA84+gR
	f1P8pg7HT8QFUotdlGo1fyAQ4QPTyPCn/Ea/3qnift/6lP6EIKaaEHD1s9W/BLuNIPKuCsusXXO
	2rC+PYHY
X-Google-Smtp-Source: AGHT+IGbZfkeSNe5O2q0w/JJMnuEt9fjiw701ccKQgIdLUjbCkPajp7lariyJGQMLVc0IERT7BvQ9Q==
X-Received: by 2002:a17:907:1b1b:b0:aac:619:e914 with SMTP id a640c23a62f3a-ab38b10cf76mr3689347366b.16.1737900348736;
        Sun, 26 Jan 2025 06:05:48 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12df2sm433078466b.12.2025.01.26.06.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 06:05:48 -0800 (PST)
Message-ID: <4f980400-1947-40ac-a062-fbfb4919546c@suse.com>
Date: Sun, 26 Jan 2025 15:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Thorsten Leemhuis <linux@leemhuis.info>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules changes for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit ffd294d346d185b70e28b1a28abe367bbfe53c04:

  Linux 6.13 (2025-01-19 15:51:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.14-rc1

for you to fetch changes up to f3b93547b91ad849b58eb5ab2dd070950ad7beb3:

  module: sign with sha512 instead of sha1 by default (2025-01-26 13:05:24 +0100)

----------------------------------------------------------------
Modules changes for 6.14-rc1

Several fixes and small improvements are present:

- Sign modules with sha512 instead of sha1 by default

- Don't fail module loading when setting ro_after_init section RO failed

- Constify 'struct module_attribute'

- Cleanups and preparation for const struct bin_attribute

- Put known GPL offenders in an array

- Extend the preempt disabled section in dereference_symbol_descriptor()

This has been all on linux-next for at least 2 weeks with no issues.

A small merge conflict between the changes here and a pull from the
driver-core tree might appear in kernel/module/sysfs.c, function
add_notes_attrs(). The code has been cleaned up here and the driver-core
additionally changes nattr->read to nattr->read_new.

Related to the modules, an important new tool gendwarfksyms to calculate
symbols CRCs from DWARF data and thereby enable the modversion support for
Rust should come through the kbuild tree.

----------------------------------------------------------------
Christophe Leroy (2):
      module: Split module_enable_rodata_ro()
      module: Don't fail module loading when setting ro_after_init section RO failed

Sebastian Andrzej Siewior (1):
      module: Extend the preempt disabled section in dereference_symbol_descriptor().

Thomas Weißschuh (9):
      params: Prepare for 'const struct module_attribute *'
      module: Handle 'struct module_version_attribute' as const
      module: Constify 'struct module_attribute'
      module: sysfs: Drop member 'module_sect_attrs::nsections'
      module: sysfs: Drop member 'module_sect_attr::address'
      module: sysfs: Drop 'struct module_sect_attr'
      module: sysfs: Simplify section attribute allocation
      module: sysfs: Add notes attributes through attribute_group
      module: sysfs: Use const 'struct bin_attribute'

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Uwe Kleine-König (1):
      module: Put known GPL offenders in an array

 include/linux/kallsyms.h   |   2 +-
 include/linux/module.h     |  10 ++--
 kernel/module/Kconfig      |   1 +
 kernel/module/internal.h   |   7 +--
 kernel/module/main.c       |  74 +++++++++++++++-------------
 kernel/module/strict_rwx.c |  13 +++--
 kernel/module/sysfs.c      | 120 +++++++++++++++++++++------------------------
 kernel/params.c            |  22 ++++-----
 8 files changed, 128 insertions(+), 121 deletions(-)

