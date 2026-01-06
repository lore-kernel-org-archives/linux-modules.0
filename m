Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BF238C3B
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715990; cv=none; b=R3XXU25WQ9VxIDZApvBTGw2/qP0JbyypcjenNaeEP3vKMQ0+bRvMnJK5fK4vKqrlkJ7CRi7AZ6tOs3MfjssTEWbw1xqf+CdD0PACIP0KJR//OMkkuZ0S9zqiiXQl0SibPv0oq8k2ZX7SAe9kxQEyEivN/6Qxf0qGrPQjOV8LzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715990; c=relaxed/simple;
	bh=Z6XtTQuVak/31CXtTEOm+GXw6SNnY5cmaSetMKwT+jk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OsLvWZ4up1HItpOzbxI25/Qm5OwGgF1bFpwiyU4W5BlQBk7kAOrSzqHQM03lmecHd+GHOiAHARWAmhsPvNzMtsWmxieEVjDoKZDjeDcys7Mn001OQt/VU2AQOcPS2PQSVMCvR1vQpEhOCwETV4KGiS2xy7M7RRtaZV2FQCQWBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF6I0cus; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF6I0cus"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37ba5af5951so10699391fa.1
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715986; x=1768320786; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lck4D4TmQSv6+gw7aJp+KqAu+zXCb6UaEjcI3/XRcUE=;
        b=eF6I0cusO7joEYB3CPDCMLsXdT1SI7mW4Z792mdpoGEsMAi15KMDou2MhhLKsIp4sy
         Mi9G5kvYtAaNxHDr+k3muz2XXfPykYo4vEMdhBci0BrYIH8t0qDaYiZSLp7cvWYkkh2+
         QpXWn5jKdVUL/kuQvaz49H8N7z+UKPvbg2p9F7jOGlXZEYVf7yiCQjfKOQWdS+1WqSbz
         Lfn/2R9ReeRduWmUeTbFdjt3bVPD+ZXd1czgaczBcRkAzwk5gNmaqLT3lq8HGgX1OuRX
         7WvBpWJZ0+mZXuTuEij75XABbvrvamVdnhD+LLN1o7TUywznoAadgBE+IEoekn3fX5x7
         Yuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715986; x=1768320786;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lck4D4TmQSv6+gw7aJp+KqAu+zXCb6UaEjcI3/XRcUE=;
        b=N6y0niTAwdgqI3ao1FOfZCWAPTYFvxmz0qGuEFAzTtQRnMwG+sgyivirvsOMitcavm
         y0E5NkRztZRt4p8xoGf4Sep8f5fFOTPJMIptfEw52G9pxgxwk5qjbVxZIQ9g/gNhpO3p
         E1r9xoDbus3+ih2ieYaSRWmg5D4NKgXT1WjqxN/5741U/4zUAjEjw0CX+vfymucbRgVc
         7s08uC3aD4OB//qUVl0cn6/gHI94Vv5TZDpnYYlpYcgoymnMvJjqQ2nsNtVcUkSsJvI1
         KmiTPLB4efoM4ndvgksVLFdiO6ZCjHxB+AwQ7eetgs0rBXApIRWU/ORdnSgcUA8n1ymy
         +RKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPQRV6Clf6dnh3epGUNDCuL8IA3MhFT6ogeHu1l1Jw1TEu5AaqB/KNwCqS4jnobs6fbqq5GmnggJmk4MiH@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeKirneuSEkj6I4rBzFxxXklB5IR7Qfg7d2dKGzLMHMQ+NhhA
	YquUDhzb2t0zVrgNK/rOn3hCDelVTZc1ZbJf11xwvg7/b/cBCm0XViAr
X-Gm-Gg: AY/fxX5Nwx96BPHE7cl0/Ejo1lFrPyF8cXmfW1/0LHvtU01A8TbduusIAu1AOmNr1Hl
	vc6ZPWy+NwR3UzZvH9VizSps3hKdjfn+Tk0G3MKUKvM2dllj0m9zVH4mnMToemEyqtmcDMRnjpS
	UEOawKe8vtNi4inHP02cgyw/aK+fVKoPnZX7dcDr68a51hlSgY3K3wiRNIouAG/kE56/z0dPCEp
	fX7eHLQn7JgZVzfKURIhKSy+I21PuXJ19TVn/ueaUMPq7TPcSgPY698R5/oFxX9B5btJG09rkdp
	QZ4HCRQjhildVBv2eyF5DutZe5gILLiY8I3+luZ6BVIZmkNCzQ4qV+cAta5RfSLiOX5otGoLoJE
	7EpRHguGhzaL2lhXkoalWmxfutjVenKPNhvA/MwZ4WLTtQLWr6M6xN14irhDOW85MxcoWAbojdy
	q/iZt0kuoPPOT4lrszwQxYIR+aXkQ76M1WgVQRkjK6lbxt/3uZUYY88uj7sF7ke/ZwzqL2UXKVU
	cvkqA==
X-Google-Smtp-Source: AGHT+IE9OAOdUXrMKduBui/D5bchnvIEnIZhBuA00P2kpvnz0I5wl3Ig+LDLP9cdnKAfsrWn9C761w==
X-Received: by 2002:a05:651c:2125:b0:380:e85:97e7 with SMTP id 38308e7fff4ca-382eaae3104mr9204761fa.37.1767715985892;
        Tue, 06 Jan 2026 08:13:05 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:05 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Subject: [PATCH RFC v2 00/11] rust: Reimplement ThisModule to fix ownership
 problems
Date: Tue, 06 Jan 2026 18:11:38 +0200
Message-Id: <20260106-this_module_fix-v2-0-842ac026f00b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADs0XWkC/2WNzQqDMBCEX0X23JRN/Gn1VCj0AXotIqmuuqCmJ
 FZaxHfv4rXHmeH7ZoVAnilAEa3gaeHAbpJgDhHUvZ06UtxIBoMm1SZGNfccqtE174Gqlj/Kxjk
 +29Yk5/wEQr08Sb0bH3C/XaGUUpjZ+e/+suh9EmGGGvWfcNEKVZJZiinNMLV46UbLw7F2I5Tbt
 v0AbOHXHrMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=4884;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=Z6XtTQuVak/31CXtTEOm+GXw6SNnY5cmaSetMKwT+jk=;
 b=vWvHwZ00kXA3kqqmGkfcE65RTJbkSd7MXMZqfhrW26nQUhsY7d8jzJnFDadW0uipAbM/9m23W
 /mZS7H+EUwRBVVJuACv7Ml1M3p/Aws0UMAwzm5uzOBPS+e75WGxBsps
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Still RFC. Not all people for each subsystems are not included yet as
this touch quite lot of things. Introducing new THIS_MODULE and
ThisModule still change configfs in same patch which is not ideal.

So currently we have problem that we are not always filling .owner field
for file_operations. I think we can enable const_refs_to_static already
as that is in 1.78 and is stable in 1.83. So that fits perfecly for us.
This also seems to be quite request feature but I did not found that no
one has ever suggested that we just enable this.

So basic idea is that we will have ThisModule trait which is used kernel
side. Module side we will always use THIS_MODULE. That is completly
private for modules and kernel cannot use it. So this unifies ways of
using cofing ThisModule things. Currently we have THIS_MODULE and also

  module: &' static ThisModule

on init functions. As we anyway need THIS_MODULE just use that.

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
Changes in v2:
- Patches are now sepereted properly.
- Removed debugfs changes as that is not so clear to me.
- Remove module parameter and just used THIS_MODULE everywhere.
- Made macro to make THIS_MODULE.
- Doc tests also have THIS_MODULE.
- Link to v1: https://lore.kernel.org/r/20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com

---
Kari Argillander (11):
      rust: enable const_refs_to_static feature
      rust: add new ThisModule trait and THIS_MODULE impl
      rust: miscdevice: fix use after free because missing .owner
      rust: block: fix missing owner field in block_device_operations
      rust: drm: fix missing owner in file_operations
      rust: driver: make RegistrationOps::register() to use new ThisModule
      rust: phy: make Registration::register() use new ThisModule
      rust: binder: use new THIS_MODULE
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
base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
change-id: 20251230-this_module_fix-a390bff24897

Best regards,
-- 
Kari Argillander <kari.argillander@gmail.com>

