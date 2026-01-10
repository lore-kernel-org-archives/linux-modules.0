Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BF2FE05D
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057750; cv=none; b=alXtQnrDB1jZSwHrhjZIDQ8ttU4gbgh52PLUzGFXEAaZcKT39aAW3kbnpqHtCMosjTEJWKVGh4ldUtP2Nio7rpGCJIZ+Ofu+DCGD0hd/yLFtJR/H9hecAg5/ZOUSGK0JFJf1cc21Iqp2OmuosQ/m+rs1Kn8XzhRF0GTaqJ/QyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057750; c=relaxed/simple;
	bh=milihCyZOaiisfuddbX3OZNgmGSzhaVbWWujvDyXWCE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TMR6niohej1xrwFHVYkon5Tv11sadZOJmHf7hu03eYcXUyVeknTB2YznhFCv3at5FfLCadn2mELsvfe+EKcy0WeTFAVRgy8cVHBxh4fFK9AGNwWXTZ/4aT2LzXuJszd58+8m1jCjKQC13+a70Zq6oN0bGHYhGZYonpkitwpL1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/Xokmua; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/Xokmua"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so4690435e87.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057747; x=1768662547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxL5IuhpQtN9jFUBPezGQaM3/k6Xw/1auJRUm1niSP4=;
        b=b/XokmuaBQaXEa6NFXENuIdccsuZefa+CveDimOHEzlfuJfKkJI0eMJZoUYy9L/Wbc
         Ib2RhBeaf1NifktBmo/CwTsaRpNLvqsCwH2Boo/Y96GNTEohn9z0/jMaNgs24VmhzmQY
         03/JSTYwVKlCeVff32OrbDCxCa0QEZKcJ0mcaKYj1t5A7GkOtrx9b47xYITeeKbff3/Q
         a9brIDnTdDgBEGp5l/L4cQZsmKjJkKN0azvpA/K3fxwz1CnoIopgp3JhlnJFmChoX5xl
         KcAXANawlaFlnkiSvne+r04xty9cWEfvZZ0RVNEiT6GrQbHhez9YGCY/z3MzK7JpiQsW
         tQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057747; x=1768662547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxL5IuhpQtN9jFUBPezGQaM3/k6Xw/1auJRUm1niSP4=;
        b=KLA9/hIOXS90rioK594JG9M3CgGscuWoI2e0Q8NgA4qt+pP7oEE+vc79UizdylmTqR
         8Q04FZ0VlpBhfiaSrjmTgx67AJT4RtewxoVD+yhSV5Aj4CinF38vrBVdgz/ArWtTFSTS
         uY3MydLJKCubH0Inli9RFtR33DZFe12ioSiVQTZIaH7L9oI/24GOfkmzVNQzLbkc3Pcd
         Pc2v5aOnv3E1tHN2OqMDTCWPoq472yh4rFUfl3zLBfdclCtpEbojUUU/a3pB4ikTdGce
         hFgpsG2IdP5QWRXec01yGrVU/kfT5cpNgROy0Sox+1f0xiMx98VwwDN4z+OXI8V1Fgw2
         xlNA==
X-Forwarded-Encrypted: i=1; AJvYcCVc3bPGq54Kjfgsl1j7RciNyUJvn8XVCigB91zY6yDt2yR7Lx5OEljbF0b7dEyhGErhMgMOEBd0iJErKa/5@vger.kernel.org
X-Gm-Message-State: AOJu0YwuL4dQoHDvZ1s8wQA8doeSZlx3H/vkjRbliafRTLqM+pXCgH8o
	arUUjkIsatuYLjVXra9AXSXdFbwZhog9v79Nu7Dv/epKutP3nXdgFxxS
X-Gm-Gg: AY/fxX6WkzlQPJD43zKrUHxlxtsJMQNTKjEDfAdbdkA74FoRsNQPBMTcDN8PmyclgZi
	1pzPQQJbWVRuyRkGcxDql1/goXkV7c+rs8M6/FI8mddxYJpzYVU4CnyocFg2CS9H2yFXKgEuE0i
	TXxgH7+YMoThL+46KPPq43obtcKKbvCZI8IoFcI3p7faZ4joVm6yo2hfND6bmMTtUr0rLrIDIsZ
	M8I7tPvdfPphdlK8zi+jCd1GnGgBAg6KOl/+mbq0GCazAYE25DEQj8jPM8KgvVdm+QxO3zjC53p
	suJqxEu1mJpejdJocjy0zBjarnuxY3QDDBaVXMs3WjRlWEDSU4wsS6aUyKGlzZmLcHu4mIOIugw
	kG95YXQwYhoO89taBInxS0alEpF3vHTWChPilHkw/kWgjj9FC2Bmx1RVY0y8C3YiGH0ZaPTCdpc
	mzfB1mdrcShUG9mvUgjjvzvYoaobtjvq93fMOeZbP/AbMNiODWJIf7pFlbATekJcZCFZ/A54Le
X-Google-Smtp-Source: AGHT+IH/WwZoA2CxA4VxBxbrefwgxBZqHrUgqZ26I2AYCzlpb1zuTNY/zU9OQhb8dPBMZsxXkuyJKg==
X-Received: by 2002:a05:6512:b01:b0:59b:8483:8d97 with SMTP id 2adb3069b0e04-59b84838e5amr1204437e87.13.1768057746120;
        Sat, 10 Jan 2026 07:09:06 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:05 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH RFC v3 00/15] rust: Reimplement ThisModule to fix ownership
 problems
Date: Sat, 10 Jan 2026 17:07:58 +0200
Message-Id: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE5rYmkC/2WNQQqDMBBFryJZN2WSaGq7KhR6gG5LkaiJBtSUx
 IYW8e4dshJc/j//vVlI0N7qQC7ZQryONlg3YRCHjDS9mjpNbYuZcOAF4wLo3NtQja79DLoy9ku
 VOENtDM/L84kg9fYa62R8ksf9Rl5YIjM7/0tfIksnFEpgwHbCyCjQXCotdCGhUHDtRmWHY+PG5
 Ip8y8s9z5Evc64aXBiAesuv6/oHyOKcHvMAAAA=
X-Change-ID: 20251230-this_module_fix-a390bff24897
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 Youseok Yang <ileixe@gmail.com>, Yuheng Su <gipsyh.icu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=5834;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=milihCyZOaiisfuddbX3OZNgmGSzhaVbWWujvDyXWCE=;
 b=Y8FCzxMIiC1XW2mn7gG0wXCHVE9jRhKI/yUpFy8xUQFQuP0bdciNY1GXHVCc1G8NlYAr8UKKW
 2S2sQrqh+igBhWIltd/VPZHvZql8YSyqArivNQ2JFGndZ2dRrM3kTjU
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Still RFC. Not all people for each subsystems are not included yet as
this touch quite lot of things. I would like to get feed back is this
resonable seperation and how we will land this. I have tried my best so
that it can be applied in multiple staged if needed. I have not receive
any feedback on this series and that is little bit worrying.

Introduce new ThisModule trait and THIS_MODULE impl.

So currently we have problem that we are not always filling .owner field
example for file_operations. I think we can enable const_refs_to_static
already as that is in 1.78 and is stable in 1.83. So that fits perfecly
for us.  This also seems to be quite request feature but I did not found
that no one has ever suggested that we just enable this.

So basic idea is that we will have ThisModule trait which is used kernel
side. Module side we will always use THIS_MODULE. That is completly
private for modules and kernel crate cannot use it. Currently we have
THIS_MODULE, LocalModule and

  module: &' static ThisModule

on init functions. As we anyway need THIS_MODULE just use that for all
of these things.

Patches 1-2 introduce THIS_MODULE and ThisModule trait.
Patches 3-12 can be applied any order after 1-2.
Patch 13 depends on patches 11-12.
Patches 14-15 are clean up patches and depends 1-13.

    Argillander

To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Danilo Krummrich <dakr@kernel.org>

To: Alexandre Courbot <acourbot@nvidia.com>

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Changes in v3:
- Edit cover.
- Seperate module name changes to seperate patches.
- Rebase top of next 20260109
- Seperate configfs changes to own commit.
- Fix one place still used M over TM for ThisModule.
- Link to v2: https://lore.kernel.org/r/20260106-this_module_fix-v2-0-842ac026f00b@gmail.com

Changes in v2:
- Patches are now sepereted properly.
- Removed debugfs changes as that is not so clear to me.
- Remove module parameter and just used THIS_MODULE everywhere.
- Made macro to make THIS_MODULE.
- Doc tests also have THIS_MODULE.
- Link to v1: https://lore.kernel.org/r/20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com

---
Kari Argillander (15):
      rust: enable const_refs_to_static feature
      rust: add new ThisModule trait and THIS_MODULE impl
      rust: miscdevice: fix use after free because missing .owner
      rust: block: fix missing owner field in block_device_operations
      rust: drm: fix missing owner in file_operations
      rust: configfs: use new THIS_MODULE
      rust: binder: use new THIS_MODULE
      rust: firmware: use THIS_MODULE over LocalModule for name
      gpu: nova-core: use THIS_MODULE over LocalModule for name
      samples: rust: auxiliary: use THIS_MODULE over LocalModule for name
      rust: driver: make RegistrationOps::register() to use new ThisModule
      rust: phy: make Registration::register() use new ThisModule
      rust: remove module argument from InPlaceModule::init()
      rust: remove kernel::ModuleMetadata
      rust: remove old version of ThisModule

 drivers/android/binder/rust_binder_main.rs |   5 +-
 drivers/block/rnull/configfs.rs            |   2 +-
 drivers/block/rnull/rnull.rs               |   3 +-
 drivers/gpu/drm/nova/driver.rs             |   2 +
 drivers/gpu/drm/tyr/driver.rs              |   2 +
 drivers/gpu/nova-core/nova_core.rs         |   2 +-
 lib/find_bit_benchmark_rust.rs             |   3 +-
 rust/kernel/auxiliary.rs                   |  16 +--
 rust/kernel/block/mq.rs                    |   1 +
 rust/kernel/block/mq/gen_disk.rs           |  30 +-----
 rust/kernel/block/mq/operations.rs         |  30 ++++++
 rust/kernel/configfs.rs                    |  49 ++++-----
 rust/kernel/driver.rs                      |  31 +++---
 rust/kernel/drm/device.rs                  |   2 +-
 rust/kernel/drm/driver.rs                  |   4 +
 rust/kernel/drm/gem/mod.rs                 |   5 +-
 rust/kernel/firmware.rs                    |   4 +-
 rust/kernel/i2c.rs                         |  11 +-
 rust/kernel/lib.rs                         | 161 ++++++++++++++++++++++++-----
 rust/kernel/miscdevice.rs                  |   5 +
 rust/kernel/net/phy.rs                     |  29 ++++--
 rust/kernel/pci.rs                         |  15 +--
 rust/kernel/platform.rs                    |  12 +--
 rust/kernel/prelude.rs                     |   2 +-
 rust/kernel/sync/lock/global.rs            |   4 +-
 rust/kernel/usb.rs                         |  13 +--
 rust/macros/lib.rs                         |   4 +-
 rust/macros/module.rs                      |  24 +----
 samples/rust/rust_configfs.rs              |   2 +-
 samples/rust/rust_debugfs_scoped.rs        |   2 +-
 samples/rust/rust_driver_auxiliary.rs      |   8 +-
 samples/rust/rust_driver_faux.rs           |   2 +-
 samples/rust/rust_minimal.rs               |   2 +-
 samples/rust/rust_misc_device.rs           |   3 +-
 samples/rust/rust_print_main.rs            |   2 +-
 scripts/rustdoc_test_gen.rs                |   2 +
 36 files changed, 298 insertions(+), 196 deletions(-)
---
base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
change-id: 20251230-this_module_fix-a390bff24897

Best regards,
-- 
Kari Argillander <kari.argillander@gmail.com>

