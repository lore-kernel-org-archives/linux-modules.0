Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9439EF27
	for <linux-modules@vger.kernel.org>; Mon, 23 Mar 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270194; cv=pass; b=iXZugpOBGc6kOSqhjJLL5qq6pfqt5JpCJHxzuJN99aVbzXD0Okzqmip5BefxzaEjC06kWrIC1bjOBaSaTt2YfmuO1pKhTaU7XQyw1ow/v4hnclH9e5pQ/dizb2qFJSiHwrgHxoA1I34DrhUnhwNKg8sv0gYb04jDmYJzMgkQFX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270194; c=relaxed/simple;
	bh=mhaI30SNytJzSanfaF6YNaJhdYu5uF4diqTzJ/Jmkig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwtT8ZEIekfaVTTzXfJv9gVFzua7/qB+Mc1HU2/+hQ63AD36b2GJ7yFtdYZAlR1OV+XoWwObU7SYf+fs/uclFkXVXT8TYOi1yGmuxmvev1NQzsdO2rV8CAVxuI5v0lzhhtJot2grlRg/wzz8u0zqUeKESzRjF2e1AI1vuxRAKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7BVK1J8; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7BVK1J8"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7c2788dso1768639f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 23 Mar 2026 05:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774270192; cv=none;
        d=google.com; s=arc-20240605;
        b=WvdG6DlhXRDIsKIhPcWXUtJyyYBRFLm+4Hm14qrVVHHPjUJHMpPwBNVGe/PLiQDdL4
         Eh5BY23NdDqbMnR1yc322SYADSKDkWF/NefkOpgr/TXygZlkvKFA+nhvvwgpDw7NurDq
         Ta7UlzKVMvtUdvele8x7pTaCOUzo1HGCdcI118d/1Ar0VFBJu/VqCYXf9ZVNOirXaB+U
         4sIM/x6k1fhFQb3L9OphGiGonzAtYPS7NHleNSuQwSeuuypK02uc5yUA2hyQ9ublyQVG
         IpCWg06kjkvqDIYlmLWHYXeS490wCqn1FZcXD0uxgEsQutWnor6LhUkp10QBzeOxRH8w
         CWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhaI30SNytJzSanfaF6YNaJhdYu5uF4diqTzJ/Jmkig=;
        fh=K1DIMdLVFblVIcKR0Rmc+xy9CEaSUn3yov9nzf4UpkI=;
        b=HcPlqYE4rNeiLLnJHwcfPiO49ny1T5jp6wyfhaqy+u5H0XHh7x+0oveB0v+/WPbEMm
         W/7j9D9ZC8VZrwG1dxGXJ6hBdIb7sBNJc3asfKIE4hL8pQFoJJlyklEyBvI/upYvMNTm
         PjxVK/cUOadWwFo9NMGR8wG/4hLcCmVMp3aDzy+1NZSJWs/PTgMsbZrV/CEMGDI5GNT8
         sv2T5CSLma4L2q0PdOJFw/w2rjrIHD1MOpdUYYgPD/akUMMtMlBCZg7aZQLJRj2WdhXl
         GEyGxzXxANIxI/095Jh0zthtNGM7/xGjzeuM9Yr8FU3pBUndLOXfDUM283B8MNk05pV/
         aZCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774270192; x=1774874992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhaI30SNytJzSanfaF6YNaJhdYu5uF4diqTzJ/Jmkig=;
        b=W7BVK1J8C7hOAv2IsN3dZ/3ZRDnVgfuVtWlfg694QvPoeqMjEJy05bHxfT//R1sWsJ
         HLkq6S+Hzi1kZRBWgiRMbefQ6Di3MwbdZc+C7pqNg+DsS2UFGUpTQkC9/9IT9gUP2zSh
         Ng1W/pYXvTP6QXir4fcj0F9HUeRcbnj+TWS0+g9aACFpOun+F3kmY2hXHRGCallO8Mw5
         YW3Kp/7KH26iuBKqigakHK04wYc0Qbal9Xnm/Epjc2KfvsryyIlda/Nc1W00fn81W6YC
         hIsR61HIxY2iEuyJLrzgOf+jZDiHVbG33ih9aQbW7HT1toQFlN+2VNUpCDxxuacrtxey
         3Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270192; x=1774874992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhaI30SNytJzSanfaF6YNaJhdYu5uF4diqTzJ/Jmkig=;
        b=Ln3klXeXuGzlB0Y0J9ch7tlCSwByuRA1tcgappZm3UGRjvIsLoSQ5Q4kp4t9WHqk2E
         HJM9PDHLxJ1wIS0W7oT41WkcMmznIkdI2GkgnY+zQLcu1eHrOgo0R9ZrC6f80xyiOTuy
         n2ysaNBEWo3dcL5QkJp0384YVyJh1xypQ+I06BcPFA5SAdL0jtpr8vJ5BRaeYIAdUYVE
         +5SYp3lFXKuDir+lKJxLlVBxK6M3LbVHH249+veIX0bLJd8hWSzVRsbRlH5nHIJtxnbb
         s6jixUkWGqklOr0DBvTCHir8tGb0ew8YJsBxSaEME441mEf0Log7zITKucPcC4r2GbEa
         aTiA==
X-Forwarded-Encrypted: i=1; AJvYcCW9diYy4SsKTDftaZgnPGmIU9y18gkXBWLcnVcrPVegYytc6Oh0WuQTx+cpYC6qpp+hdQ4s1ealW+EgCxdA@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBpaJO+1fcZrIFLraBgJ6GtwtbbYdldsKJsHUnq0WAs93xiJM
	FVjJrv9KsTgwKOF4TtpIFqU2AiOtGILoYgbF1R3i2SkgoZKot9VeoyIvTG4N9b4TfjDYSyS1Ts4
	CSJjH6ssL/wAMIdILrNBTTz7on4Cq6BC9vu+AfVIR
X-Gm-Gg: ATEYQzyhyzWerMBdwgrA7w3IvvGrRj8L2ZaOn0sbI9Y/xb3VbNqu9gARNxiRnnW9HJH
	BSMpHcba61nwJ+w7K/a6H50hiN32blUM8y10YSOVK2XVoBQLwIYhanlLlLEf5bluyO1Q+Xyot+f
	iIA5Tu7PSihK8eTSLsQUL7gm8qCFaYlMs/XKRsSmIk0/ICISFbOnHG1YC3nqtF6A2JM8FSOM6eZ
	7oOZu32wlUI5qmmdyG4sKdnEsJUHGBTl02FTt4a7O1HUT9id/ipUSdbcpBPy67dRr48f9cQekAE
	GeE8aL80O9/eLV0XULHHx7btlMFG+UrRZC8RYAe6tZWC2JVQfSwhY2/ryItXHTGZDVn7FIBfMbe
	Pefdx
X-Received: by 2002:a05:6000:2601:b0:43b:4352:1bd9 with SMTP id
 ffacd0b85a97d-43b64290e38mr18021646f8f.48.1774270191803; Mon, 23 Mar 2026
 05:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-module-value-ref-v1-1-32507e1085f1@kernel.org>
In-Reply-To: <20260323-module-value-ref-v1-1-32507e1085f1@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Mar 2026 13:49:39 +0100
X-Gm-Features: AQROBzClFWF7ntMYn_osU78DJFaK2xsZEw0vRnwYGIT2wSlft8Tag7vijAEcrPw
Message-ID: <CAH5fLghnHvnSNsZ_ME14KiPeKh2V93L1ZQJOqs0Ztn4YToam8g@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: return copy from value() for Copy types
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:48=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Rename the existing `value()` method to `value_ref()` which returns a
> shared reference to the parameter value, and add a new `value()`
> method on `ModuleParamAccess<T>` where `T: Copy` that returns the
> value by copy.
>
> This provides a more ergonomic API for the common case where the
> parameter type implements `Copy`, avoiding the need to explicitly
> dereference the return value at call sites.
>
> Currently `value_ref()` has no in-tree callers, but it will be needed
> when support for non-`Copy` parameter types such as arrays and
> strings is added.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
