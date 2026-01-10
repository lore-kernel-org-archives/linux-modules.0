Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48F347FC8
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057774; cv=none; b=fzPz7lW3/Txq2dh36VdsUkc71hlUd3JCeBZSm+LMMYcCAsSphhx/HRsjBdin2S3b3CDVStFKZeIJjN/N5OEW6NdOHhkpXewWJins3zMW3/0S01i7zouRoTcGUjlZr6sk6U++tavYxDnJV3WJ1lSdVgM2CXl9SQiJmXL6RxU3WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057774; c=relaxed/simple;
	bh=16z+/p9/lej3nOQDzP3jcxjHTQfVy2r7xALqKBRkYmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fvO5vSEUy0nNTLG/2rmYNjAj+rocsltUGhmE8a5IcnuEp/BzCGbvFqHd/3uruvkaxWIQZ1qhS8v2VQeNlLcebQ9ooLC5MQzQG4G/jIOFC+D+G1p3m0ZCR//Vp73iUwg2Q7fQwUznoKDllJhNA0Gc4abE6nvWe0xmX95lstuLRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDYtQ7bY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDYtQ7bY"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b710d46ceso3959222e87.3
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057771; x=1768662571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlDCOqcpxSYZNQqRknLGjEy40YAMcG3nssNg0J3FjxY=;
        b=VDYtQ7bYrzbIpfZr3TKveqV+L0Vt92aohVqmBQpLJOuvNZrmYy9iRhj+hntu6mX6F/
         I3eullZ1g3ehZQoJ5MpgNASAedkVjsK7IgSlbadGEj1yGbgB/PyKaamTQE9vURL6CroJ
         RaWFnna4K1TkF1HG37OwWC/BLmSH8hqwSPnsu43LGI3+wsPK9JrX7IdPWYmHOD7BFLnr
         Ll2bkZ0TKiXrfdjti0gNp2lammdoNfSzLkTyvdOWN7HBB+7FClyNNT0SSs7QrG0V11mS
         87eZw1u8tEadA7h7uoJO2yEOXKwZz/yFUFku8vXOxhE9w48U0v2xF3SyngfrIN5v+1WA
         Rdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057771; x=1768662571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JlDCOqcpxSYZNQqRknLGjEy40YAMcG3nssNg0J3FjxY=;
        b=uQQUXcN0LeQfbruPSjOxeIadidB06wTUQBbwj2lzD0GOVn5okYcgk5OSfKpINL1VkH
         fMBlB5kJ0nqhiXSqqApPhdzcanbuAuU6PlwkMLP0uZea9AqA0PhxpiXnCDx/3gojOoTO
         /B2r5JWN3Dv6crRMHVmOeW0paAkdfv+UPZme6lo1CuLKFo4ZI+OF0ZVRMjJQvHJR6MQH
         YITtNkjQl1ndeWNzGRCHImaGao/ukn4+MPaMkz9Pp3ATf7LXzMXfUcS7O+vWZAzsIlle
         rsQEk1V86nQVbuf+xnBjsX4JjGCWHrzIgv3cjT5jxR1zbAFb8CqhqtQDic1+X3utKvTm
         rAqg==
X-Forwarded-Encrypted: i=1; AJvYcCWaHqDqwDfgIlfLMEGKGXT90vzQBv5s+JGUAx/tYpkVpXx8iUyCr2Mbvenb+hL/GOuXrX9RUkc/fKlzuh4d@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wrTZ7z5rVt1XXv93gaEhTz7QcJsNU09qw6BRRa2aTI3wDKgm
	8oC363Xt/YyahSnnHQpORYUuVQwjYS2TcfXUDqqeEOpTaxpkKlGrXI8G
X-Gm-Gg: AY/fxX4XMF3TfQH5NuYcVEeIvERX9tGBKKaBoZNNTtkxiJAsXoTNFn8g8SiYfMlqvNH
	2iBBS///j3qeIjO88rYpDMvfFWQ3AGsPWuFtVseWebWpvRUP4O8mqvPQ4dZwgdPt2QJLwthkRyJ
	znbLSksd7t9YD0HN+NFNaq7Eq8DEYUMt4t8okv6rYBKWxtbdFMyooEUe7whpEzVLp68XHeeM9i5
	wOcNRSmGSiPJW00sDiRQGMcC54vpDnIQgnEu6yPPMxW5WDh/SYGSDForedpXInnfa9YUzNTxBeP
	1B/fS/07fNpgRhjq7JYXo0SqwzVkA/LHjEMwivk7OBT50wqaeas7e+loNxdl9on0JDmHZbzaCRu
	Imvh2UWHYjZDZH9Zdv93q/vOXjEDSLQIBJ4aGDzo1rrYL2J2smV/45/lIO7IBp5fMBYv19Fx+FA
	BzQmDkKQHXZOcSNvniAIzl8867GkOefHXYG1XzwQtl4Qd1/MCB6Quio5v1WFhERxFMElbBhkoWy
	MuTubRB0X0=
X-Google-Smtp-Source: AGHT+IGPacMYwDU7ZheyDzxzZJyrY1/QIDRayqvxVVTESHnbCTj5MKU+UYyTZd3q0INr8ESQRaxDqw==
X-Received: by 2002:ac2:47f2:0:b0:59b:715b:4fd8 with SMTP id 2adb3069b0e04-59b715b529amr2926411e87.13.1768057770686;
        Sat, 10 Jan 2026 07:09:30 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:29 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:07 +0200
Subject: [PATCH RFC v3 09/15] gpu: nova-core: use THIS_MODULE over
 LocalModule for name
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-9-97a3d9c14e8b@gmail.com>
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
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
 Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=801;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=16z+/p9/lej3nOQDzP3jcxjHTQfVy2r7xALqKBRkYmc=;
 b=2ckocfo0Z4z6nSjUTwSYROhT79u6Ea3s3woTynS15mrnKNn85RGMQtrTTrNA6LV8iIWiR/ceh
 WrveCD3jfC5Creqw6HHlcTQlrQlgwbm8kUGr3jdvp5DOGyCvHfXtMrg
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

THIS_MODULE now contains also name so there is no need to use
LocalModule anymore. LocalModule will be removed in future.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/gpu/nova-core/nova_core.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index c1121e7c64c5..c8d6f9e3be1c 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -18,7 +18,7 @@
 mod sbuffer;
 mod vbios;
 
-pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+pub(crate) const MODULE_NAME: &kernel::str::CStr = THIS_MODULE::name();
 
 kernel::module_pci_driver! {
     type: driver::NovaCore,

-- 
2.43.0

