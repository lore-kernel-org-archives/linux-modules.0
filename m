Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795283427;
	b=n5iXy7RB6Ta25UkrLSBFJfVTlbb0IquYWHZwmo8N8WKqtlkYpCC/h8i0XWN6OK/7xq1H
	 X9hbXKsBdV/Do4vIzR79hELMGq4DhXiiTKm9vHM7tfNptvJnrjutwZzlnMvYdDxP9GP2J
	 N0MjzZs6nej4n+lQQ6mLrLYLvApKry5R2e9KyPHjtbCQ8NY3bS2Udc4HpwZyvVp3PXDyL
	 1NibKfs3NHTwULnLgeM+1YuqymX3qFbFSDqRdWmPKnHpikFq3N0WB7kJ6RtNQYa3tckPq
	 8NXIYqKChquFBhDH0mbCEgVuDHx+hUxLEMMLbw5tM0KCuMFWdiYGsLOviVZJ9eHQFpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795283427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:X-Google-Nh-Sender:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xu4M4Rq3wV8DgH+HqoVMbKaQd8J/D8bo49jgEyUz/XE=;
	b=brTmyJES4VF4SzC0qvuYTWfCF8EmHhr9/pKdbGZQTJe3vMTdVmYlO1XpsGT57YYDvBwH
	 /yanB2R8HMFlBfE5v/633YvsooF/XGc2Bndg0mYTla0A/K4BYDZbqpvZbPagVFztTsgpa
	 ACuygxnzir4V2oFFyqkQ9S1s/K7aJRsjcvUcMe9BMDtigfZddgroBOKQAkHfB5HVxbeP4
	 V7SxQU+o99sswOcTaqbn6kyxud/ACocn6m9fHrdWY8FXec734e2AnHbXNpDK9yAhqgzeE
	 aGdfjext21tTIwnng4/YjjvEIIbFTheadKdKTAQg66k5AVQCVR8T9GlzK6xfwHpeg8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLk6aNgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAA606A32A
	for <linux-modules@vger.kernel.org>; Sat, 21 Nov 2026 17:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EAA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLk6aNgl
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b10d24345dso17634167b3.3
        for <linux-modules@vger.kernel.org>; Sat, 21 Nov 2026 09:50:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795283426; cv=none;
        d=google.com; s=arc-20260327;
        b=OzgOCWlZVJWMNcSf81SB/VnIggw0IGw2wO/1fcoEEVrcgGzjmJs1ewMYr3ss7G8Zes
         VOUan8Z0xCyBVfPXgBkdj/5GQjBVheSaImobEugEvdCaXMlztJofDbMTtEibhxCvysHY
         yz/NghbI2jRVNXq+e40a4SV1IkW0JlPycfcWsgyNWQ9gzit6c2l8uyW9vdcOMDxYvDd2
         TJDzagGDC7V/5fAXmKq+1N34+rAuwtL0lwQxmlA/zoy2IsKDV04At8NzkL41RWt4cdBL
         mKWpeb+w6C7n6yGGnqUDOhpd+SraIdUdkf3iSvkc5whm2E4fkMa7Rbn4gBY1Tuzbl1Bi
         rvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=Xu4M4Rq3wV8DgH+HqoVMbKaQd8J/D8bo49jgEyUz/XE=;
        fh=Fi2etbLE+6zYnWaLPMSb5vzAuYdpR5Qd5mNjOpHG4TE=;
        b=RzjDWvfTfXjnwMKxpRSBLiuaHLy9AXeA67CZcW0svudih+owKgm3sImMTN/n9QW+Iu
         /+5G/GHv5pt953tiHh3jLLiDwzxOTF3oJNH+Is2gAwACUzhB8C5s3sv5CPoOHbBu07dh
         KIMGfF8738q966J1qOLj7VefUscja/j1hcRavg927TNTn+RepruPkZ0kAhtRJb6XRwBm
         E7HCXu+FEbC5xkeZWqg5RupqAKS44dlDA8+BUdC82iZlk+pmTlIMOUaw6KxN0zpEGLIw
         0zwkQwE/DRfFEiIU1BezZtPLhca3I+9fO5Z3U4CP8pyz+VwIRpy0VbIOUzvHW7UpdnYw
         oi/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795283426; x=1795888226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xu4M4Rq3wV8DgH+HqoVMbKaQd8J/D8bo49jgEyUz/XE=;
        b=iLk6aNglaHLSfejsdDCsnc7RX/dVGHcxO+3s4wAzV4vM9SNB+fdAI0/vrzVTvqc6wc
         Svla8+8t3JiJp43AkfHtiCef+rSVtiUNXCNiNnDXv0Dx04IxY9NLHX1ExCHffschAOCp
         zy9jJomDn1DUzt7yRUM0A1XYpKDHMS4SKU7rqS7KN91edKs9iqJeydIhuhyr1Om2NmdV
         lRkMFCB0dne8OaN3X19CagYPJxfBZpEhA+ywtlMj6Y2hGUQw8E3//KydV1ur0kiFCzYP
         oBOPzz4qB5+Klf1SFq2yHbYTX/p3M1ScQrrPlf53r3/tBT4Cy0VAnnSsIel3030+r89S
         czUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795283426; x=1795888226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xu4M4Rq3wV8DgH+HqoVMbKaQd8J/D8bo49jgEyUz/XE=;
        b=Iy+dTQqWQOIpXwVnvhgL2ht5Rpg0VbfhZm0EIsbTb1c0IOxrODPYj8vAxtmL5O6Bzd
         FMdXAkroFnfyyzy9CGXK0zqkBHd1My0qKRVmvpJWMejWGmNgoU2Nj///JEh0QG8HjNdY
         GzNYoNBzHsw/mYD3QUN4wVwGsxdDe8F0Bht8rIP58ZJiETPBnUBbSFmKnxwJhsyaDcqQ
         j+MMril9O3RxlWFOHqffzlTCf5w1VAs8uveyLfQp0R0AU+HE3qp6TA5K0l76xWE/4MTv
         PBf5qGxMo6R5b53y3wAPP5SX6u4Ik8OQvanij4ja6Mc+JqZIbbUJlycszszLd8i5H/sB
         nQpA==
X-Forwarded-Encrypted: i=1; AL+hErFclKR9IsUNgeURWjjot8dPK5ZTUyEkYTIrrayEEB0W/41t9EqeU/qv0ANFvniRi3NyZx8UqsG0XC7RolQt@vger.kernel.org
X-Gm-Message-State: APuU4Z8WlAslpIj5+C8sjo8ilzxncBBSylVisL4uawIsZeMbRZZFwsEl
	i15Ehwpsh+Mc3WZ2IyQLQTPAXx66hxxiNBZt836Xqy1N1L+aQxdw+pWyBpxikmRc3/2dz2nPgmM
	+lzaGmTrI1VJiuuqzsiR47lJ6BQD7bnY=
X-Gm-Gg: AZFdTZewg1amw3fLHxlvSd+mMBYwoOM1h3aQyeXDdyJ4oP0QByLtumkldUr2s9ZWlwy
	Tt2OyVkaJreS0sPLBQsOh9Jit4lTPcEECtMGal0UXpf039A6sQbzdguipbKpXFXKPBvr5YPycOR
	Seh99OJ5qPHj7v0Z534X0NRHEm1ND2aLg4Y/iE8mf9/zMfPD+EMmPYGUzfbZtVLSOl8YfaV79sd
	ahFjYjrLcW8h53nEjhDHKHoWvFEdssBPt+AZPHOL/SqcH5LOYSBmEWyWH7Y7fbWle7tOC27rIFU
	7w2vTCtTC5XQYtx06Q+kSySXOJenHJj2f7IrGnb6E3WvV3TsZwcQRNk3FpEaM/mSDaKswJbPufY
	tNj832KpnlRUjQRc2FF9QcPg8gdb7f/vJI1ozAii5k8WpsrEvDMhZo/v6r6lKCNtltdxRtQi7hq
	b/l3oVWX7jix8Xb1wm59ZTm3vJT1NUiNzA6Yg8+4waVvHidcW1CemYLlyHF8d5STUlmFqccIEfE
	kwNqWpoYBqihvi4lluZGnRVlBI=
X-Received: by 2002:a05:690c:b86:b0:8b3:4911:2dc1 with SMTP id
 00721157ae682-8b5204ae0e7mr30662797b3.39.1795283425537; Sat, 21 Nov 2026
 09:50:25 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 21 Nov 2026 12:50:24 -0500
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: peder.bergan@gmail.com
In-Reply-To: <CANiq72kWXzP1SWUvhOT2k-rNjopnySXeBkjwrx63V2QUaLpnGQ@mail.gmail.com>
References: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com> <CANiq72kWXzP1SWUvhOT2k-rNjopnySXeBkjwrx63V2QUaLpnGQ@mail.gmail.com>
X-Google-Nh-Sender: AW_J_UoEym23HGvNQ5zzCr2fkBwchbIS39LY0o3smkAVD0qDlNYdj5QfaNo8KarZLsYzQWlSiaO47uwNu7Ha77BLqJukKxnb1c3zQq1IDN7OFCWayb3yR_WclseoF6OW9P26WFQRXvNRjHgOWmoGpPAk7z_ifQH_LJgp626YEFxxIOIOhhyVgfEATPSFauhLyvCp9Dpd-VJp0i-FFJ0ot5roV2PTcyNx46IlCqKQGMzHu-SbF6WUbJBJ4C6Us7wCCwDfy5Nx
Date: Sat, 21 Nov 2026 12:50:24 -0500
X-Gm-Features: Aa3M54oiSweFMBwEnXr8v5RhNblmDh0i71sIY4AU6gHF4PbmUFHsoRQyMcHMRfA
Message-ID: <nh-eaa5d67e-6d05-468f-9f19-273bc5b23ad0@google.com>
Subject: Re: [PATCH] rust: put C helper exports in a dedicated namespace
To: miguel.ojeda.sandonis@gmail.com
Cc: ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com, 
	work@onurozkan.dev, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, wedsonaf@gmail.com, gprocida@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

Thanks for the review. The export formats are literals, so I'll use
:=3D for both. V2 already added the namespace import to KASAN's C
metadata.
https://patch.msgid.link/20261120-rust-helper-namespace-v2-1-14315658f59e@g=
mail.com

For v3, I'll build on Giuliano's assembly conversion and generate
EXPORT_SYMBOL_NS_GPL() directly for the helper list.

1. Would you prefer I wait for Giuliano's series to land or send v3
   with it listed as a prerequisite?
2. Should I keep the KASAN import for v3 or move automatic imports
   into modpost in this series?
3. If you prefer modpost, should it add the import only when a module
   contains a Rust object and references a RUST_HELPERS export?

Cheers,
Peder


On Fri, 20 Nov 2026 22:34:24 +0100, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Nov 20, 2026 at 5:32=E2=80=AFPM Peder Bergan via B4 Relay
> <devnull+peder.bergan.gmail.com@kernel.org> wrote:
> >
> > Suggested-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Link: https://github.com/Rust-for-Linux/linux/issues/216
>
> Nice, thanks for going through these old issues! :)
>
> > +rust_export_macro =3D EXPORT_SYMBOL_RUST_GPL
>
> Do we need a recursively expanded variable?
>
> > +++ b/rust/exports.c
>
> Conflicts ahead; this file happens to be going away with:
>
>   https://lore.kernel.org/rust-for-linux/20261112121512.1670347-3-gprocid=
a@google.com/
>
> Cc'ing Giuliano.
>
> Also, what Sashiko says seems reasonable: if we do it this way, then
> we may need manual `MODULE_IMPORT_NS()`s in some places, which may
> become a bit annoying, even if there aren't that many mixed language
> modules so far.
>
> Actually, perhaps we could just import it in modpost if a Rust module
> has any Rust translation unit in it...
>
> Cheers,
> Miguel
