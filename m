Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83614F9FD
	for <linux-modules@vger.kernel.org>; Thu, 24 Oct 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729810817; cv=none; b=pyBnAWnHkkvdC9LFqmQtyac1pScLBXD6uHThYve+tkRImSkFHI7CbH7zYYNwek/m23Iq3dNJ1vNPU67pkiuZA9PI/SkVHlmVtUdvyeN3wXnwtZopGJKWUoJVeuGaKOwtO6D5lqQ0ssiA1yJWRJ4Jxk8lahrUlVqFMAecr9zqPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729810817; c=relaxed/simple;
	bh=bjkd3I8PVvryUBj9cjaPUkOhrD6exRyenT2IT2meDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4oO/2dumz3q6hcTxZjZJWI04ST01cpgqU6trP3BWJriQyR2xvmzeglsqJQ3yzfaPrGwP0d4mAMRxPn9ufEXKTU1qV9NAl+woTkIGUCO/yrWeFX0pjSpHI58Sn8FsNizF9SkSCSjfwsGYi5xBKMFmlQhyTVee+N2WfA6vdsLTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMk/KbW5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMk/KbW5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca4877690so35045ad.1
        for <linux-modules@vger.kernel.org>; Thu, 24 Oct 2024 16:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729810815; x=1730415615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1N/YHxtexapkwEa/KzhGq9uJiSxlgwwlfK/Xn4dDvz8=;
        b=xMk/KbW5IhCvPKqnco1uNdEZayG6EvHJN0R8UMYxj4R5TnY1l1zvYNFS9Bgv7M1IDF
         IwIdxI+BWsOHpIbBRyAHR8zKQZOixgRb15IDDdVvso77YkoJT2aoBS5tcaoiNb3otLUv
         +J/5uhhHDOHzg7alPcCteqkNwv6ANqhMSL9hvAsm4IXRrgs891rUSqfFO/gfglpBIqTW
         8jLju8gQp3z03stQ7kHbEajMOi65BwHPv3llnJrYY5+5d0Vxc689Er6g8TB4f6WxjDGo
         Svq6JmtdXYi5JwJ6TAbeGfqBCraQUxN1DfReg1spY9tm9uIr2rOFS+yMS0feHVC0I7JJ
         mJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729810815; x=1730415615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N/YHxtexapkwEa/KzhGq9uJiSxlgwwlfK/Xn4dDvz8=;
        b=r4YQQr/OVzp80nJXCyGuBO99iTh0F2XCYXNhC7mzjeT8vX5u288UHeOoOimlLIIt8B
         mKqilVx7Lu8fPsiXdgIAy6p8pJ1fLLj3+SOTP5e+nQQVcsZ6B5QKsxTdoVidTVwNMcnt
         m4une0c2G2bCg5HGTMVFPoIrLaVPZ5+YiME0S4QhPcNWYDIdfeeFe7JlI/TFQRr46Rej
         k+Y7Z6RILy/Y0hdzaaGCW9eZN5DFHhBVxApP3aDnLACBoL2Qhi4bU7v1mbT44geN9aMp
         f5GJ6PBAvRGFNC8ht5QdrYxTdsKvxwhoTgto7qQncQxon5+CYNGUi3qCOR28g0KT1sjU
         Ftow==
X-Forwarded-Encrypted: i=1; AJvYcCXetCCvcabWnlHnS1+G96If/vj1HB8rFrIZaGnuvh8zT3hy0HA/D5rBXg6Ax7zGenlY6fVJaHNFk8nNXRwI@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJEgi70kySftN/mNd5hqJmCy2X6AzT6C9jeBVv7T7jDYmDy7R
	oty1XSQtO0J06+cic/PONH8lRtoUhx83Cu0uIj4vLKh+lQ5Bx3h7IQyB4vBvYw==
X-Google-Smtp-Source: AGHT+IF/Dyf8ydqbgus1FTEPKZm1RYCxf83AYTE17X2EEDE3xOS0BfMauJXXQXefEKpmi0ZHk/dmfQ==
X-Received: by 2002:a17:902:d4cb:b0:20c:6c50:dc80 with SMTP id d9443c01a7336-2105b1ccb2amr461955ad.9.1729810815119;
        Thu, 24 Oct 2024 16:00:15 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3555c1dsm29218a91.4.2024.10.24.16.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 16:00:12 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:00:08 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Matthew Maurer <mmaurer@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 1/3] modules: Support extended MODVERSIONS info
Message-ID: <20241024230008.GA1382412@google.com>
References: <20241023-extended-modversions-v7-0-339787b43373@google.com>
 <20241023-extended-modversions-v7-1-339787b43373@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-extended-modversions-v7-1-339787b43373@google.com>

On Wed, Oct 23, 2024 at 02:31:28AM +0000, Matthew Maurer wrote:
> Adds a new format for MODVERSIONS which stores each field in a separate
> ELF section. This initially adds support for variable length names, but
> could later be used to add additional fields to MODVERSIONS in a
> backwards compatible way if needed. Any new fields will be ignored by
> old user tooling, unlike the current format where user tooling cannot
> tolerate adjustments to the format (for example making the name field
> longer).
> 
> Since PPC munges its version records to strip leading dots, we reproduce
> the munging for the new format. Other architectures do not appear to
> have architecture-specific usage of this information.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
