Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30AA1F192E
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244890; cv=none; b=r0WNvuoq5U8ThMWMpesnyNqsXlGhxyZ+rNgQ6ulOhSZI0qzi7RebCVopv7aqBTkCr6qKEDNbt7wVNRYvLDKVcBVTH8dgdi5oHKQZbxaq7EsqMya1wCkbo3kfiBMdOYdemj75LTfN8Gas0u9QbaEvYOdA0NrcUapKVjWtw7jE2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244890; c=relaxed/simple;
	bh=d750XEbNBh45WZEXvFp98QPRpIEawpP16SYsmo3jXHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dtPApBxUxu8X/Yy5OWrEO+TZ7qzK6cY+EI3B+5NeQQbeWZhCpNeVzkp1BdTnx7Hy9mznHOi5LQFAcYxsKK5ZmVuXoVWosexK/LyNldHXcE+/ksOS9uBxIZA5FARp1sprBB15YPS7yjXbXfW4WHKHMpPrOtC3OXieJ3oeWCn1/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd39Agof; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd39Agof"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59583505988so17252341e87.1
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244887; x=1767849687; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGdE5vkNreRWa+aNq/2mpC1URjTiZenF177VT5Zv0EE=;
        b=Yd39AgofIXGH/YdYcExZu7uKRrRNq8Hqb2I73dkxdU35M4sazmWa2nvIdmZSpVxg3v
         hSOhpca6jmoWep3UMYyzApISgWaeITdkxs1o/KuAzCRmglYxgbpcZpRqSga3xkxGX/NA
         Vbx89xmWMIpvlkMEc1o4yo5r40TazJaisG+0iHpB/FexoX7l9fTswaxGCSpP7FgwyS2e
         rOk3GEZJ5PJjSEW97pstIU5Eo9hkk5leIlWf8xpKHi1PAiAYXuW/QGgYKvXCvx9n4XO/
         RAA8a7RJweg9lxA/eeFUEnBAIcEkOpLRK9o5lGbMYPc2RCZUcWbCwkH+uWRvInRmRtDd
         ga0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244887; x=1767849687;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGdE5vkNreRWa+aNq/2mpC1URjTiZenF177VT5Zv0EE=;
        b=VIh7LQK+Ibvw4gDYJeyQvoakVvy71cF7EVr+3sqnluhsBaSLWlafEzd/H6b2l5s0b+
         2uV5PxLZ5z+JMojofXKXo9WQsnLzmGlZ7ItKFVIHNz2MxI2Rgu8ovZlPSeUa4V2no7aH
         +EqyxSJSVKl/WIxNS8rl+sxCHzamXx3578lwx2kge3mYKBafsM3DDSlMK2ijCcSTvfmw
         Dymtmt+cZovN51ta/6zcCCTOYvvhG8Kmhzvaxqm0JPXTMmgOMP7KylPuuNKtmW4lT9xx
         7RGR3pM6fVucPhHc88gRxftnXBPAiZtnz/YKEgNIE9J2kwhCIzsTxJLXvhR7NRsVvlim
         S21A==
X-Forwarded-Encrypted: i=1; AJvYcCVCTaabicsdFWtq8gh1H9WAdE3B1ZU0S5SbOnQMLSpAvo6ul6dzoL7gQfWuFtXCDKrTX7QTvdW0SMxhvaBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXeiSfYVKWI5QMAcivcQVMgOyfHWyowTWkIqG+yC4fssLGK9p
	oRIv/OHFrAo0OTPYXWa2/lwOyJBFQ8vQTILFGo7ckSpynHSvT2E1sW2P
X-Gm-Gg: AY/fxX6TDa4KUrCtMNB9c0tPAjwI86HSVwacrJ34Rqidb4Pz9zuJH07o1btWk0DbaWn
	UEpKIrT8xcTsE+8SmCZD1TIGFAJ43tKuJZdRnszNkmP1zmzbNhwzuFLx0q/qtjDS+ICUbHdvaJr
	F2IDMT2NB8bH4LhJxL2MPO5nQL558yPzkcCV1GXn4wyfOzrEyJN3q38p5b1KCKXH9VUX7g38yu6
	Rc3GOEfolSXo2nLkgAAeIyPU13MBSGKNQiKeBa+Q2chZ+2bWBq94J2LIAmPIEPELi9qx5FBSd/V
	avifhtrIqTBl1/1GOuiG5gMh22PZprlNdwNIBE1zFDCLxgYDjQWbmoYbWlyHyxecmxKxrM+WGm5
	InwMdm1lATBf/H+Vm6XzVkfY8D7CGTLNZ74tcTiTK7ODM3ekpXFSE5RQ1l0+CVlocJpRH+BJRIc
	VhmZBq6nnEhGxqRsRBcSdZosFRvhd1xOE+prjR83+einb4WSPmnpVkxXsr7f1nPs+SH56PqhEAf
	RsCqQ==
X-Google-Smtp-Source: AGHT+IHZriBBr0PXhxXKR/y0BJsmhFkS1LQ/QqrrbeetrOZFLiHUhJOxalDrHlDyEkiA2LnHaYPv7Q==
X-Received: by 2002:a05:6512:2399:b0:595:83d5:7b47 with SMTP id 2adb3069b0e04-59a124dcbd8mr14238581e87.5.1767244886425;
        Wed, 31 Dec 2025 21:21:26 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:24 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH RFC 0/6] rust: Reimplement ThisModule to fix ownership
 problems
Date: Thu, 01 Jan 2026 07:20:44 +0200
Message-Id: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACwEVmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2MD3ZKMzOL43PyU0pzU+LTMCt1EY0uDpLQ0IxMLS3MloK6ColSgMNj
 EaKUgN2el2NpaABg32XxmAAAA
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
 Jens Axboe <axboe@kernel.dk>, Kari Argillander <kari.argillander@gmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=5943;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=d750XEbNBh45WZEXvFp98QPRpIEawpP16SYsmo3jXHs=;
 b=bpVBBl8wPyL5ukIFKh5IWfBK/k3UXg02rMEPOWGVp2PgKPwgwaeWsxbbw/lK9S1rPGw8SYbfJ
 fw3WuPigsHPCPrzKEmOnjAWzGSkzRhSk2KOUxSLERbRynPypr+VDxbk
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

This is RFC and just first patch is ready. First I wanna discuss if this
is right way to go. I also need to implement this so that build does not
break and do better splitting. There is missing signed-off-by's and
commit messages so no need to comment those kind of things. Feel free to
cc more people if needed.

So currently we have problem that we are not always filling .owner field
for file_operations. I think we can enable const_refs_to_static already
as that is in 1.78 and is stable in 1.83. So that fits perfecly for us.
This also seems to be quite request feature but I did not found that no
one has ever suggested that we just enable this.

So basic idea is that we will have ThisModule trait which is used kernel
side. Module side usually just pass this trait forward if needed. Or
they can use THIS_MODULE impl which is now completly private impl for
each module and kernel create does not see this. So we can think if we
wanna pass other module data which have through this. This could also be
used to give local module storage without using static.

There is also some of github issues for ThisModule handling:

> MiscDevice missing module reference counting causes use-after-free crashes [1].

This will be tested and fixed in this series

> Ensure ThisModule invariants hold

Yeap. Now it would be really hard for kernel create to create this by
accident. Binder is still using .as_ptr() but that is easily solvable
and after that we can make .as_ptr() private so it will be nice that
kernel create can just use .as_ptr() modules can just use.

> Add ThisModule::this_module()
> 
> Add a new function ThisModule::this_module() -> &'static ThisModule
> that is only available when MODULE is set. It should return a static
> reference to bindings::__this_module. [3]

I do not this is actually good idea. But here we take little bit
different approx so basically this is done also.

> Suggested that ThisModule should have name() parameter. [4]

And that was good idea. We can remove whole ModuleMetadata and usage is
lot nicer. It is also possible that we could have example trait PciModule.
which THIS_MODULE impl based on type but that is think for another time.

> Initialise the owner field in struct file_operations. [5]

Yeap. After this is totally possible to do everywhere. This series will
already address most of those.

[1]: https://github.com/Rust-for-Linux/linux/issues/1182
[2]: https://github.com/Rust-for-Linux/linux/issues/212
[3]: https://github.com/Rust-for-Linux/linux/issues/1176
[4]: https://github.com/Rust-for-Linux/linux/issues/720
[5]: https://github.com/Rust-for-Linux/linux/issues/720

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

Cc: Andreas Hindborg <a.hindborg@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
Kari Argillander (6):
      rust: Enable const_refs_to_static feature
      rust: WIP: Introduce ThisModule trait and THIS_MODULE impl
      rust: WIP: use ThisModule trait for initializing
      rust: WIP: use ThisModule trait to fix some missing owners
      rust: debugfs: WIP: Use owner for file_operations
      rust: WIP: Replace ModuleMetadata with THIS_MODULE

 drivers/android/binder/rust_binder_main.rs |  4 +-
 drivers/block/rnull/configfs.rs            |  2 +-
 drivers/block/rnull/rnull.rs               |  3 +-
 drivers/gpu/drm/nova/driver.rs             |  1 +
 drivers/gpu/drm/tyr/driver.rs              |  1 +
 drivers/gpu/nova-core/nova_core.rs         |  2 +-
 lib/find_bit_benchmark_rust.rs             |  2 +-
 rust/kernel/auxiliary.rs                   | 15 +++---
 rust/kernel/block/mq/gen_disk.rs           | 31 ++----------
 rust/kernel/block/mq/operations.rs         | 12 +++++
 rust/kernel/configfs.rs                    | 19 ++++---
 rust/kernel/debugfs.rs                     | 79 ++++++++++++++++--------------
 rust/kernel/debugfs/file_ops.rs            | 50 ++++++++++++++-----
 rust/kernel/driver.rs                      | 19 ++-----
 rust/kernel/drm/device.rs                  |  2 +-
 rust/kernel/drm/driver.rs                  |  3 ++
 rust/kernel/drm/gem/mod.rs                 |  4 +-
 rust/kernel/firmware.rs                    |  2 +-
 rust/kernel/i2c.rs                         | 10 ++--
 rust/kernel/lib.rs                         | 78 ++++++++++++++++++-----------
 rust/kernel/miscdevice.rs                  |  4 ++
 rust/kernel/net/phy.rs                     | 16 +++---
 rust/kernel/pci.rs                         | 11 ++---
 rust/kernel/platform.rs                    | 11 ++---
 rust/kernel/usb.rs                         | 11 ++---
 rust/macros/module.rs                      | 43 +++++++++-------
 samples/rust/rust_configfs.rs              |  2 +-
 samples/rust/rust_debugfs.rs               |  6 +--
 samples/rust/rust_driver_auxiliary.rs      |  8 +--
 samples/rust/rust_driver_faux.rs           |  2 +-
 samples/rust/rust_minimal.rs               |  2 +-
 samples/rust/rust_misc_device.rs           |  3 +-
 samples/rust/rust_print_main.rs            |  2 +-
 33 files changed, 245 insertions(+), 215 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251230-this_module_fix-a390bff24897

Best regards,
-- 
Kari Argillander <kari.argillander@gmail.com>

