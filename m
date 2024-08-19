Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE91D54CD
	for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096337; cv=none; b=bC8NU1/gGrEdmpeqw3drTJP1ZKtMe0obfQcZGUaW2W0coUZdPAZZtFWPzC2i/vWJsrqVNln530Bim1CDScO0DmBOuQwTURUtokEqT+n4di6NTcWrAwGBdBhRh0vs9Sl295tP1t6ozYetB2xw4hTdgmmnrjAzD4ggH2duT6Od3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096337; c=relaxed/simple;
	bh=F7wkcHJPXIPuDfH/klr4thKavbEnJmwxdbEiZYRhu1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKJqq1MmwYfwIn7L9Q7w28yXKfEtpjxWE3CLNCeEA8wRYJGZ+iDBYSpiWHwJpqIOy/n4LNv+LhztCh9wY6meyON3doZj+iLxNJEQy9s6XSms5ZDdqz3Q2mlwZFpZ/h7lfO0DoqUJzA9P12sb8BZvZoRcQNKTUUpB6IR2nE30Heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jqy44aHK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqy44aHK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201fbd0d7c2so28430935ad.0
        for <linux-modules@vger.kernel.org>; Mon, 19 Aug 2024 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724096335; x=1724701135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeS++fCKemkXhDJMjat3ElWefP5AW5Wy1oKzA28CFNw=;
        b=Jqy44aHKfCucjW6dSdgDbzaqx2bnXrzPEbfetshLmrEaw/8xyi0TxC5h7b8LHg8N/t
         kouRMUJCIINWGrPLvd4Sca5u2B86Qpu1OApbkfFi9jPE4QPO7YgUqf48/pp/avbE7M1F
         lXJKrVlyu8na4SVtkpsonw//DihGztrsDcWO8orF6NQltKwhUgETN4S6mzahBatvl4yK
         UMKc7DJodi8BjCyDHN1sSBeQM4hD1rgsoVbAMCZPZst7QDHwCBS9MNExih6UbG4Uzp3E
         K7W7VpffRMkE0tER85oamhTkLH2AFLpW0FSWfqnMxWZ7uyCW3dVhQkwozOJ+vYV/wb0k
         fn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096335; x=1724701135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeS++fCKemkXhDJMjat3ElWefP5AW5Wy1oKzA28CFNw=;
        b=brvGYatrYETVBU1gBA6bqQeA9Ql0f8axq6Ij2lcUMMnSRnblMZaaCW1CVEBV8GDgvH
         iibse+5gwGaFSqnTgpcrPBpi99TtQDrTd9sqUKyGbj0mEYZbFzeJm9zOhdFN4fEcMkUr
         NCy9borqlYdAD0PMgX0f4P762IEDAgrOGHBYX4rMr80qBkdxxYANUhcFAADncOXPF2c7
         BbZKikV3BwMcs5fiOvd/uI1Q7N/ZWrz1RIX3WwLaYQpqkVc6HbRg6W9j3Qe1KD59mvXj
         NHeCQ71dfq8DyWKhaMmuAjDThahTS4cd27nP15ohbcalWyE/Hgm7AQ9FvyVheor37zXz
         JUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVFi/GFJWh00qSthP1KXOks57cEqhTP01pbShvR3DFM/W0kClo51vzCDCRK+kTsSoVk488kUwxoaPlZGQP+@vger.kernel.org
X-Gm-Message-State: AOJu0YzXablwtDjrz6fGEZvFn86QrhWxpA/jRN2wkhGTe6EpZgCUzfwV
	UKBG1p/OVA+9deriroJNyETsfv0tzd2N+YSSf3fmY1l+xkGcgWgX1/zTwnkGHw==
X-Google-Smtp-Source: AGHT+IG8oRBHqBpvRvU+j9ijDv76wPfUzxrx1g+I09GD1WWcWllKaTLicpQtA41S0/MWaq3kkTtGZA==
X-Received: by 2002:a17:903:188:b0:202:4d05:a24a with SMTP id d9443c01a7336-2024d05a587mr34136775ad.16.1724096334977;
        Mon, 19 Aug 2024 12:38:54 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03197b6sm65427305ad.69.2024.08.19.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:38:54 -0700 (PDT)
Date: Mon, 19 Aug 2024 19:38:51 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 16/19] gendwarfksyms: Add support for reserved
 structure fields
Message-ID: <20240819193851.GA4809@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-37-samitolvanen@google.com>
 <2024081600-grub-deskwork-4bae@gregkh>
 <CABCJKuedc3aCO2Or+_YBSzK_zp9zB8nFwjr-tK95EBM3La1AmA@mail.gmail.com>
 <2024081705-overarch-deceptive-6689@gregkh>
 <ef6f7294-0afe-46af-8714-ed4a4aaee558@proton.me>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6f7294-0afe-46af-8714-ed4a4aaee558@proton.me>

Hi Benno,

On Sat, Aug 17, 2024 at 01:19:55PM +0000, Benno Lossin wrote:
> 
> For this use-case (the one in the patch), I don't really know if we want
> to copy the approach from C. Do we even support exporting kABI from
> Rust? If yes, then we I would recommend we tag it in the source code
> instead of using a union. Here the example from the patch adapted:
> 
>     #[repr(C)] // needed for layout stability
>     pub struct Struct1 {
>         a: u64,
>         #[kabi_reserved(u64)] // this marker is new
>         _reserved: u64,
>     }
> 
> And then to use the reserved field, you would do this:
>     
>     #[repr(C)]
>     pub struct Struct1 {
>         a: u64,
>         #[kabi_reserved(u64)]
>         b: Struct2,
>     }
> 
>     #[repr(C)]
>     pub struct Struct2 {
>         b: i32,
>         v: i32,
>     }
> 
> The attribute would check that the size of the two types match and
> gendwarfksyms would use the type given in "()" instead of the actual
> type.

This definitely looks cleaner than unions in Rust, but how would this
scheme be visible in DWARF? You might also need to expand the annotation
to allow replacing one reserved field with multiple smaller ones without
using structs.

Sami
