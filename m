Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B3515889
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663032; cv=pass; b=ZHrdcBAC4zjvo+XNuxEHAvLhRVE2nYNgdgfA0B2aMUP0FfuJHvyQMZo1mjzDm60TvpJglvbUCDdDYPHoLl186ZbnqqjLCqSh3Rrx2nAY0GYgmYfx7/5gxOxz/CCO+FfzADOPTWCd3Kjdy42N/8tSZT8U4bo8+Er0jhycNczrliI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663032; c=relaxed/simple;
	bh=3cEU2FX5sjCKV/9YY1zUxvndLq56ff83jvaQSJxMo1M=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=V9geRudiz8bDBBdaz0ZSNclGOsl8TX1msrXDg0ab6ZGT7wZkQl6LXxxR9FkzfwVdXJ52wTJ3zgcsRj8hSDQUfa0vLs6GFq1i1yx7Lfnd4lUBcxSgmUljYSn/caSSTGUyuaQ3LyXZoFu2/KXMMNFwtG45+vAAWNG0uJyF2QpOhLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp61h2Ze; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp61h2Ze"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aac9321so1011660d50.3
        for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 09:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663030; cv=none;
        d=google.com; s=arc-20260327;
        b=r2NYc67M8vTwcjT2Sfzs3LYFROSalRyyblD6xp2SZ2xxsM3XW/MxyRBPivi1lZJF3Q
         XmoZrEEEW0lChCJ3LJCAdKZbrwUjAtEUI0AfFHWhGvhS3pIJ8/SDl0d6L749emVywnwN
         xuBwDIoa0+08ZE597RmzaZ0vsEzNTWi1Ktbnldz1fL/L1HBG8efomdxRsJli+ZCbxtF5
         ueZxl88RmA4Jb8MUgDfKWH1rgQWw9SnBtYmiB5gB476Q9R/UD+j04ohRrcQPQSW4W/tF
         NImVN3+ehqdtC96fomAEzg8yG3XOEvhqxtAmbTOJ5pkb0Cmt734lN84ic7mBK9ducYWy
         wDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=3gfRyW82mA40VTKRDF3tUXjLNXgKrRICPFMxaXpDiOw=;
        fh=fdRss8L325mUiLwiR71EIvmfhZkG16t17xGSewnVu9s=;
        b=dTwW2KQqOVKVo+bLAg7K4a7cPlTb5YL4b/ucYYY1I80BG8eU4P3jkVOFOnzW+N/zRE
         Ks5CNHESdqtFxs4mMvQsx3pgIQP999JoFLWuIcgh3w+XH1aqEGTEwpQsP6Nku0njB6+m
         L152P4L4SGYkqO3sZhUnTCH3JOE/PuKz/oxFcPzX4Al6CKykUdDIG/9LxlQSwnyweDQ4
         0xX1cy7S3KO+EVwxGkOFAxU3KIhMPLdRhNqMCXA7t+H7vYuNsz9hlxiZi15if2+rgELR
         A5yz7fJGqgXVy2TGHivgGJKZpHn2f9Rc1TlDYCuusRtj1N8j3I4UcYF+Di8Yia0ImS8B
         TzHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789663030; x=1790267830; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3gfRyW82mA40VTKRDF3tUXjLNXgKrRICPFMxaXpDiOw=;
        b=Hp61h2Ze1RvXPyBtj8tx5eReEdsu2Y3Ggt+fyjlmCuJNGXERbNeN8YKWC5pDW+YTrA
         2Lue30qtPiPFP++9SAF80N6yeoyBbxORmyH/ubfoMJ6XbqyxsZVC1Q3vWeVBgAwT2pQ2
         vHzCAz039rST0ONfRNDFjBfGB4jTPFB097fc13c6YL5NJoZl/W4U7RUL7hcKQJf8hWnl
         dD/PUGYFMCCUiuuGj/Xdwuq4eB2aArbCFn1sJvDtJwkHH2RUqSeY+UAQ3HPl6a+HSVa8
         gJyf8ViKsSLPl6F9Jq9VLSRR+2O6eChS3094694a9OoXyCqf62AOxWQi3erc9gYZ+zKX
         iohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663030; x=1790267830;
        h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3gfRyW82mA40VTKRDF3tUXjLNXgKrRICPFMxaXpDiOw=;
        b=E5PFbXQ+D4eZ6JA52dEciNDhTgFiv6soJicYXxq4U9kbvzfr+ZNl2/m6Nl1lpZFsKd
         aSLxm04N8KRcdwA6cs9f0oX1oZ1oK2+w5QXUOSmmaOffy7SCGn9wMMSkYg1k/ARw0gO7
         7HevD7xkv8FgS4aSbRJZkbWl1VLN5vDsa6M6yyPjLdSx61noGQzLJYy5/2MQJmfhIzrw
         RZt9FhtK/5Cvjx8KwfKlSiP4d4/4jXwFuU6he6LYltvMxlgjr2zlH7ybe6wSKPUj2KzA
         9UiLpSGjBQiZHJU7F8Q0o5cr7Q9rDaIII18f6UuZ2tZ9ZT30ovjoaBz1JHUqW4woilAu
         wmDA==
X-Gm-Message-State: AFuF++lVfSsTiMHLq5P45iE3KRQ1lLdkjpHFGy/5y5nymUCH6mCURWWm
	7fWbGUxc2CUaPSM6c1Lwt1y9fzR370OLWPTtO4taitWcNu9CxE2WD5QQZ66Zw/4WtUuLXycsHKI
	AV1PLiuzUUI9uC9sjVxFKbB/BYQ5GpMkj5w==
X-Gm-Gg: AYBFou1bKIscoCJTA+/b+afjrDGHRig+seTXXd7kXMpmJLCnVmqlaORqPEfHNWOxMRR
	HXQOf6Emyil1kuLro/p70Wj44L8+g2tdeJZ7pOgqP+gEAH6pp8Bzs+SlAQHHCn11Ql4ywAJC3zY
	Ub/O4cPPX7bx0yEoIQouQMVQC5DpCymAvSutFTMCtmTge40Ug0gmDprQ2M30Um+Lj50ICxyxAQG
	RfIR35XtUKH83woFwBdHO1t5F2Cy6eqAOu3BQk/JsnmuVZ02lxDcNHMdUzPv5JUdyn9Q2ETUQfM
	EIp2OCHFI41+3nh6HrG2QHVVjATetP7Cjq3ODw9yhgeH+F0SvfTL55yLUFoJ786AYiqNso9/9KC
	HAUBYQxZ16OfeJtdL4A==
X-Received: by 2002:a05:690e:488e:10b0:66f:c1be:a66b with SMTP id
 956f58d0204a3-671632efcd9mr1602288d50.93.1789663030062; Thu, 17 Sep 2026
 09:37:10 -0700 (PDT)
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 09:37:06 -0700
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 09:37:06 -0700
From: alan.hovgaard@gmail.com
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Sep 2026 09:37:06 -0700
X-Gm-Features: AcwNN1XZxIlaFpvS8z25GVHhe0THKe516EU7lhiqTWQJ---kQUzEP4QyLHthtGY
Message-ID: <CAJEbJRDvQ99QY1suT9n-g2LQqGBgFrMj+9=d63xe0qt9_-Jqtw@mail.gmail.com>
Subject: False-positive missing-firmware warnings for devices not present on
 the machine
To: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello linux-modules maintainers,

I am an Arch Linux user writing about a user-facing warning that
appears on every kernel upgrade. It is driven by MODULE_FIRMWARE
metadata on in-tree modules, then printed by the distro initramfs
generator (mkinitcpio) as:

    WARNING: Possibly missing firmware for module: 'ast'
    WARNING: Possibly missing firmware for module: 'xhci_pci_renesas'
    WARNING: Possibly missing firmware for module: 'qla2xxx'
    WARNING: Possibly missing firmware for module: 'qed'
    WARNING: Possibly missing firmware for module: 'aic94xx'
    WARNING: Possibly missing firmware for module: 'bfa'
    WARNING: Possibly missing firmware for module: 'wd719x'
    WARNING: Possibly missing firmware for module: 'qla1280'

None of that hardware is in this computer. I find it a strange
antipattern to report missing firmware for devices that are not
present. Treating that as a WARNING is, in my view, plain wrong and
misleading. Why on earth is the default to warn about hardware that
is not even in the machine?

Machine: Lenovo Legion Pro 5 16IRX8 (laptop)
GPU:     Intel Raptor Lake-S UHD + NVIDIA GeForce RTX 4070 Max-Q
USB:     Intel 700 Series xHCI
Storage: Samsung NVMe
Ethernet: Realtek RTL8111
Wi-Fi:   Intel CNVi

  Module              What it is                         On this PC
  ------------------  ---------------------------------
------------------------------------------
  ast                 ASPEED BMC/IPMI server graphics    No -- Intel
UHD + RTX 4070
  xhci_pci_renesas    Renesas USB 3.0 xHCI firmware      No -- USB is
Intel 700-series xHCI
  qla2xxx             QLogic Fibre Channel HBA           No
  qed                 QLogic FastLinQ enterprise NIC     No --
ethernet is Realtek RTL8111
  aic94xx             Adaptec SAS/SATA RAID              No
  bfa                 Brocade Fibre Channel HBA          No
  wd719x              Old Western Digital SCSI HBA       No
  qla1280             Old QLogic SCSI HBA                No

None of those modules are loaded. lspci shows no matching devices.

I understand MODULE_FIRMWARE lists every blob a driver might request
for any supported device variant, not "firmware required on this
host." Distros then treat that list as a checklist when they pack
generic storage/USB/GPU modules into an initramfs. The result is
false-positive WARNINGs on ordinary laptops for QLogic Fibre Channel,
Brocade FC, Adaptec RAID, old SCSI cards, ASPEED BMC, and Renesas USB.

A warning should mean something is actually wrong with this machine.
I am asking for this default to change.

On the kernel / module-metadata side, that could mean:

  - Distinguishing required vs optional firmware in MODULE_FIRMWARE /
    modinfo, so initramfs generators can stop false-positive warnings
  - Or documenting a stable way for userspace to know that a firmware
    blob is only needed if a given PCI ID is present

I am sending the same request to the Arch mkinitcpio maintainers,
who emit the warning today, and to linux-firmware / LKML. I would
like the user-visible default to stop warning about devices that are
not in the computer.

Thank you,
Alan Hovgaard
Arch Linux user
