Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BED4BC003;
	Wed, 29 Jul 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335042; cv=none; b=DC09xxX3+hMFiy46ScKl03agQ1LTydG9rSN2RMTlADVdFMbi7XMkLw3rUjfez6FWNYoJu6VbwUSHlDuGCcyvSQuhG3Mq2PqR+9rF3rM8+wbnwB+Y4BFsXZKWM88iF3sZ8jEsiurVLa0cOrzkNrVf9er6YZ4Sk/WKDP61uWcfSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335042; c=relaxed/simple;
	bh=0d7Rg5BwmRCIW23il/Hg/oCp4Mj+VT5u/4XHQmf4cco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwxs/ylG1TkG/v1ihHlGUAl1OgLZHgFveSFcWMFoeU1MM0yp8FLszZrTyYbHDcBDU/HIE8ogGZ+J0ZJLzLhqtbTgG6xWIN3zXlnE03bMxp1S5jjIL9Ykm4XyNQw4WUcG2N3W/CxTzzY6OY1eU3ubHsK9d3fgmHxSokprCZAvWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDquwMYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDquwMYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D11F00A3A;
	Wed, 29 Jul 2026 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785335040;
	bh=y9UyaQqkrLiI46oxG56D41N9AHaltzW+DnQMUtlsBPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KDquwMYSo7uSPcUN9wd/bZQoVsSAjgd9xqrM+h8o7uwn97TsU6oaA5uIeC9Isa30F
	 nsgVGX3ckvebUDdcSrE4M2Psn7gDAfezKf9O/ozGHeKAh0u11pMK50x21x2TmE7etM
	 6WfilRjgelOmlmajCRi++9Z/S7LzD43eq23rgZb7j1GZGqEVvs18W0Ts3LLwkHGADa
	 YRLwaCma2sgtSw+Y7397NW7JI5iNk/Bf+6YlaBWQBRZ+dF026xIR6iPJFg6C5dGzNs
	 9V5UEj2T0jaX1dnobok7q6luxhm1wS9BMjnqbSAH3JaKtOmzA6ZdOJs8cip5nCaycx
	 MyUy71riqnDhw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 46552F40067;
	Wed, 29 Jul 2026 10:23:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 29 Jul 2026 10:23:59 -0400
X-ME-Sender: <xms:_wxqar4dqBD2UAAZYJY34tWY_iHnd6QVQZdXpLmfybgsZBLOP8jiNQ>
    <xme:_wxqasktGF7SvayUbSIIPR0A9On3GIMuf1-cnlvroNrz3_Xc3GdrzqOchfzROAyT_
    qvpxVdU6Te-daG7Ef3bv01bd9sdyuhadw98fJZ_3fe2cLARtt_pAAM>
X-ME-Received: <xmr:_wxqatJtAumgstpLM75MPTXTDohpVguK96DiqmFYd1mjt2n8Vktl9H6ki3wzkqLtgwFKMhWw28RYo4sqcZhUz0-o_rcGI2G5>
X-ME-Proxy-Cause: dmFkZTEUCb/Ik8dMdiU33XRhWM/MkjrbXq4BUWZITAMXRIWXU3ukziOWVQOlDPQuT3pxXy
    2JUeF17IZZULjTQQPvBGbTlCrZVL4q+IJGXbd1djwJGzrKbpjOioRIMDQaDXfY6zKBiBzi
    n9kccYewLMKDoOvxjrbtN7fgit+1yxM1riZT7geVdDw8iUfDtjWmFpzPw2nfzxEcczn+k+
    lTgOgpyDTnO6sf3qQdvX9cvjoECY6I3wPQJjaHVdBJduLJO3z1DtZgkgUUbW75J4pLJ1qO
    axJsxwk+HKO67iam5m36MvKWKglmWZ4LegVBM6StD2SI0glcgFb68lzbawTiDhxcoJIwCe
    6TTWyCwsiuF3JZ35KYwCTXm4DN0S3BfJdRGfpp69D2vv9ns3F9QHA/bHovfNkbvCPucdgw
    ZhcKZ9PmrKE8nguGR2b1xJ0HbZCesQIcmo6MlD3Zoeik9pM7OCTfM2ulcBGkMnDTlyrT6F
    7sXtPamMMQ9fhxfRmBjGuJvOHxgTWWFjVdfIedj8z3K5oEuHz8XckAl+PQXYfiL2AO8JME
    EFOGa7y9EfR5Rdg7vR7FbGrcpFXNkR4Oe5vNcI5ZhDWW4VOY/wobdLDGerw0qOlIW05qBi
    D1HN5EiTN24OHvEoDqHhblgDHyFV038UZbu/x1hkmGvhJlNt1ixxJMKePTmw
X-ME-Proxy: <xmx:_wxqatG1dYxb6gyr1LPHjaALYRVTOP-0y2uPXA-9AldnSb0CWbEGQA>
    <xmx:_wxqauNv4bJW-VEpxvX2rzFKC4Fs_3ZrkGNJ_AOpDEOPXYGwsGjg-A>
    <xmx:_wxqan-moiWXkXWgsEwsDyXdYks8cerIb3r4zJLj7JpiFjp_2IrCiQ>
    <xmx:_wxqar5Qs5VGb5job0fOWXXu0Yo7CPE15qnww5-jVZy4EF8mLiYfVA>
    <xmx:_wxqasUmVQpUzlU06Y-tlqcqCE_FnV61n1S-nhvhlm8Qz6qZd_oJFG79>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 10:23:58 -0400 (EDT)
Date: Wed, 29 Jul 2026 07:23:57 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: sync: add SetOnce::try_get_or_populate()
Message-ID: <amoM_QJkwwoqsGHJ@tardis.local>
References: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
 <20260722-setonce-populate-v1-2-fa7455c26c42@google.com>
 <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKB42GHIZ8VZ.17ASJME0HTP5A@nvidia.com>

On Wed, Jul 29, 2026 at 11:05:55PM +0900, Alexandre Courbot wrote:
[...]
> > +    /// Get the value, or populate it if it's missing.
> > +    ///
> > +    /// This method is useful to avoid spinning on the internal atomic state. If all writers call
> > +    /// this method with the same lock, then they are synchronized with each other and it's
> > +    /// guaranteed that no caller will attempt to invoke [`SetOnce::populate`] more than once.
> > +    pub fn try_get_or_populate<F, E, U, B>(&self, lock: &lock::Lock<U, B>, f: F) -> Result<&T, E>
> 
> From the API perspective, this still leaves the option of calling the
> method concurrently with different locks. What happens in this case?
> 

Calling this function with different locks is not a correctness issue
(SetOnce::populate() already handle the synchronization). User may want
to synchronize different groups of writers with different locks.

Regards,
Boqun

> > +    where
> > +        B: lock::Backend,
> > +        F: FnOnce() -> Result<T, E>,
> > +    {
> > +        if let Some(value) = self.as_ref() {
> > +            return Ok(value);
> > +        }
> > +
> > +        let mut to_insert = f()?;
[...]
