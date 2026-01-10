Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD97347BD1
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057782; cv=none; b=Yxe+Kx7RHjh8N8Slwd31A10tSlet1AixOWfogaiKpmv1fUE/Fvdb2uj4BbXTFDU+TYMMIpa24oTjx7FmQTT+ono/VleFALq/Zy2xArASzTrZoFOBaQZMc+NzGYru+o25r58VQl1SI17JrQGrH6DHh8tgpL09wU2dKGcYnmf8u2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057782; c=relaxed/simple;
	bh=W71manYc49CiWAv2i0/k3IAXEeJXVcWy8Fdli+uPecw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X16svJMls3122dCcaK70Et87jtmpxPCZN02vuqmZeh2JDuW1n93yKgRSVaZ6yKyWiPAFLugf2PI3cOcGbGvoFMOOMFDwTS1LJfBoNYWT88l3DN5oeHL6T33C3Zl8eJq7vzH1fcCcuEoU56Sdl9cR6EQ/Dbswg8v4aDktE1OieCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYKGo33d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYKGo33d"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b834e3d64so1533152e87.2
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057768; x=1768662568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7uhurcFR9DbDTq+yEkMv+ps4y/ZlCrnBHcpx9/LZbw=;
        b=OYKGo33dtgLdkgKac80pkbkYmnbrFzqEO1eS/KWpZ4yFjK32T2d2xTreoU50aGtuzW
         WU+wcNxprqAvr15C2z04ol6rrhdEVOwOCWUwQSmud/iG4OQ9lSPZKgvGA6ngiprcp9Xz
         8l5B5loCR9LAykT2P06D50TacVt79ajwTvZGjVXi+PmzEj8Cop77Oz5zSvh1C44IJuWg
         QNWbOB334llV5Qxc0ir2AeDRZcV6t/gap1mjkbTJn1VNDGOpBLq49kgf3NoPEi6WCcXM
         OObSJNYt83hW4JShSY13ywOzNotM34DF5/dVGS6jRYxpCxY++CkMys3moz9fr+R9HikS
         +71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057768; x=1768662568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7uhurcFR9DbDTq+yEkMv+ps4y/ZlCrnBHcpx9/LZbw=;
        b=jHCP5YhkctUptX7Ss9RDU7nVVUHvbVv+ZDCw9Ws6T+CKUQ2NJMYHVvItjg3S2cuOZ2
         oGEA/sjmgAUCvLxH1oOHwDhXwUpgb9gAn/bxFuuv51TKSIvJbqz/5wZvclhHkMYeKSX2
         loIOSxpt/tCFNZBys2+iLKlWHGay5bFga0egI7uoXhwjusuV/BeUM5E2Wi7tnEXHtDx5
         jVKkrYPTFD04Gw14cqvxzioQk3p5OJ+NplKxR8K5o7QgpniEpLds7M0tasNX1VXxntO/
         Q4pGYN6/u5GY6Ay21HcLNYCHd+A0dkgA7u1ROc+Dp+S/SgJKgg9cGSoxRL/U5a+qPk8C
         49LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXsupU0GepJZyvvmoCvYDhibjOuE8aZ8vifBLOcT/GlYLTjSP9l/gzu1+O5PZReqeMZz5ec7UwgAtBEbAH@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzglu2nEEZM3sl7AXePFty1mpWx/YuKXzSOmWnNOJbveSOK0Q
	ns72YQyXo9kWMOi8QmbMyiSj0Z70gDHQ3HeY2f5ttiiN8tOSxbBXjgEv
X-Gm-Gg: AY/fxX5RophJ8HQmGIWDnz/m830TarE3kFea6URM94qrhoMBWZ+jQHf5N59VTj7UFYL
	tQ671GSYQi7dwvS8vivXLqxxg493bHbKD9NKEe2nZLuaN1/SxF6TCmj89pAr4c7UKFkZi3TUBI7
	NLu6hbqrM1m3GNfjnWFi/g7ysRySjQMIGvjGz5cINnDl+LV35MiCYdZTUKGIA9gmwXkMO9Qdx78
	MRs4OoLUPJ5uCklXZl8ZItk46FMcJ9GxX7VHhBLsuY9dfC8/xTvtH7ZIkVWv4E9OChZ7vkk7+m1
	FZY9kBw3Kr+rafgl/d8Y4ROgOhPHF2juBNc8qG5KNyiR0vogBLjV3aigLphAyoO6DellIQUMvai
	fs1LQ3iv3t0WSgTVKb6cWrURI9vINeFmMXB45nYjNAYwIc+sLn4DZUaJHu6ro9IPVTQvxOQfif5
	tFY/LNPh3g37uIEpUPvXSOnvpRuixy5zxZyuSKGVWEVZs/12TzSVRv13sEaFP1HTSqP080Cedy
X-Google-Smtp-Source: AGHT+IEb5d+vaUkZpyBGq+p43WuUE9Ufr+umE708zZAN3Ro/I3sh2nhVyXVGVrxWTqDPfClDb90idA==
X-Received: by 2002:ac2:443b:0:b0:59b:70e7:4128 with SMTP id 2adb3069b0e04-59b70e74285mr2359072e87.53.1768057767898;
        Sat, 10 Jan 2026 07:09:27 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:26 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:06 +0200
Subject: [PATCH RFC v3 08/15] rust: firmware: use THIS_MODULE over
 LocalModule for name
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-8-97a3d9c14e8b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=820;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=W71manYc49CiWAv2i0/k3IAXEeJXVcWy8Fdli+uPecw=;
 b=TI2FZYAl41BCzRj1MSNDkzQDfQwog9xX66xfNZZ1pkWkh8jNuIQdCerLykM46eYcWqAczB9aJ
 vKnPExldgPFCeNcqUBG3nc2rFIsDDwEfn0QDI1LdCeaw7ubXjJM3bIL
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

THIS_MODULE now contains also name so there is no need to use
LocalModule anymore. LocalModule will be removed in future.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/firmware.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index 71168d8004e2..2702f01c0403 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -206,7 +206,7 @@ macro_rules! module_firmware {
             const __MODULE_FIRMWARE_PREFIX: &'static $crate::str::CStr = if cfg!(MODULE) {
                 c""
             } else {
-                <LocalModule as $crate::ModuleMetadata>::NAME
+                crate::THIS_MODULE::name()
             };
 
             #[link_section = ".modinfo"]

-- 
2.43.0

