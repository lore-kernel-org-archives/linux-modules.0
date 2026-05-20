Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3725634040C
	for <linux-modules@vger.kernel.org>; Wed, 20 May 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293124; cv=pass; b=BaiBUEAwsGNdOImRv3HByUHgN8LUafp3DFOPGCtXncWdj+41UhJNcTZJr8YlkcWAqpzVClMhj7vb9JUgmOcz+3+zyNXslS9b23t5dP4Bpd0FG28qdHAE1Ngsdt9VRSPdSW8O4168jbuP0Jh0EPKJKBTkgENCFJcrPNd5QdIjbJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293124; c=relaxed/simple;
	bh=2EDlKael8RTaQN7c5fkMhXdnQq8CX837PJmCWXpE4tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P60nj6ezjl+GSQAtBYKxF5kJ6NDM6LToNDoEowwJd85hQJNPMR+e++Yn4oHyM2aJjleHhrDzKl9uN3JJDKeHWPx2QELm3bB4h/b9MhtcTfmyFtNZR+oX998rBBVQO0y/XTTiO3VcruWNkLJ4p+NTGsvrsGf47SPHG5c0S/4Vkw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMRi5Gwr; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMRi5Gwr"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365eecc5885so4681281a91.0
        for <linux-modules@vger.kernel.org>; Wed, 20 May 2026 09:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293122; cv=none;
        d=google.com; s=arc-20240605;
        b=jipM3lMVvwpE2tKSE19qlkBHVkOQgU0qZq1z+DEV07OpEfvhfAE0AUCoQ+vs3/fm/L
         +wCCfq18qAEQRblRSuLcxbGBWBp+wxRa8KSpx4Dy8nn9AOYh3LQs7ueqrJLOCVLC6ySl
         toAodcFVZsH2cNGBbgkxaqjG0efWjUyQFbknLE31gByLDzMNHJVJtivF7OCQkMumafO1
         rQOefCYLl4lMXH/kS1akVbsc1WsA07pHs1Ep9hUsznR3BTwEIcUflHyHsF+7g5UOKoJK
         nid04sZgJSrDkT9306H9wedlcrVtUxskKXbiOGXqVtX/UyrUEJaVVpjl+M/9qzgpycm+
         /NRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        fh=8/oFfH59MsHngKOMUspQVR2pW65kypSRCzTUDC9SBew=;
        b=KPAU98cWSULccSrd9mBR9brECpEO606dKQVw2kbk+pBNVB33SUFI42vpWe9MyAHHCX
         EemXxfFNR1FrPyNG3wDSeg2RzeVaaszn1Sso86Q0YK2advVpCKMOsADmmGzsL7XdE3Ln
         jMfz4kRplV/iMYdRZYjncYGPwPU1Vd4CbTDZ4lAgXL+TTOBUHv7cA19XKKH0l1mPLX0f
         hWtUyr68CHEp5uJbhqT3GiINLI6h/LXAuajZLWKakhNMTiZcFThDEwl1+tVjsoni+3jE
         //L+15szRTn71XbRBYaQhvJ8Ete6g2XPClq6Tp2zYT1km/yi96+D+558vnKDWtcGiZ7U
         /GAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293122; x=1779897922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        b=MMRi5GwrWhzLs/hp568pTV01vjZdW19UD0e0SDzCOwap//3eciYWnocNMjlQx9W9sS
         jvZ0Y1ExkherY27Ai5rat6HM1thtJv7vRKYDpsfbE6DTRLaLMog2bYDAbOvd4F+yx3nK
         wW94ys+S9cEG0acZA1JAvi9u4zzgpvpw/I66ob/wOk1OmsTCC0rNwwAqSlbKXX1AQmEO
         eoOfoD8oHMrevj+s+8tADqsOUAq4sVR0N8I8j+nQ8aUpnf+0KLAfn712XaWRhr67rDwz
         s/2tyexjpWwAUHYbu1yBga60tLwi8+DzuXe4qsO7GZqFijInfoV0JAZ302Vh2/tceOOl
         HYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293122; x=1779897922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzZEO9R9MG/Y+UDP0CkIZv8Ywq/jQNn3Y29wLwYcdyc=;
        b=tTvrSzBFd+4KVolcAyFeO1b1V7q8uvNuGWZnro/c3bImuPwmsErz2RLZ/wnpnUbL9Y
         WRHZL3FTqsJIw9eQvBwgceY17isKaOZ1b394DOZEeLKlJExNrsp/2O6q1n/nngCyERLW
         rV0wz9a6SSJwroLefxbkRO3Ghqj201j3fdTD0qFWLhM2b7RDdzN9086RYn2o22VLGxGE
         rgTX0hkc0uIplodarhAunD+bTU8inGz/9Gx91lB8dCsZlrKJOyMqCAVO12DnM53OcNh4
         hw2S7TjphKNCF8TIqDer3kT9Z/vYjt/CBNGv4EuAQ0sbapwmg8SLPnVTvLJV9RbkZpkI
         xPcA==
X-Gm-Message-State: AOJu0YzLu/v56J+NMa2ApQxWLKk0fS5DqkF2jayv5CKrDuKOiPYrnJVh
	0NcKpKVL6y7tqrzZ777WO+RO177uKcqgc5fcvx6c/o+6IMQiMxDXpbS1QtILhVpiXt1IQ/W8Igt
	tgaxvMf4zyxmF57y2r0uWIhzg8ATNs2E=
X-Gm-Gg: Acq92OFC135n5+bWe/Egzc+ZM6sJnCKQEybXm4hGAeiwWYybX78FqT4fTQWL0RoWrM8
	eYjnaziqoFJLA/L0VXRutSeaaRTJG2hueSsgUEExIPeVJ7U1fMhYWTX0IHXo06wpIgVoGDD8FRb
	GW2wxN3CYO0aMxv2s7e0poxeCg5dpO1UVfoZaq2KsgIZ9mj59d+G2TxdQo0W7i7tZ/VaLNPqAn4
	zZ4QtL8dgVvqeRtkq5d4Mx7cjT1lp/bd0Lt/bAyDc++YgaHS9StwtSI5conKz+pibnffgIC37Vd
	52XMUzfY
X-Received: by 2002:a17:90b:2743:b0:368:b176:c5a8 with SMTP id
 98e67ed59e1d1-36951b76e8emr25519894a91.15.1779293122447; Wed, 20 May 2026
 09:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com> <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
 <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
In-Reply-To: <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
From: Afi0 <capyenglishlite@gmail.com>
Date: Wed, 20 May 2026 16:05:11 +0000
X-Gm-Features: AVHnY4J5glQyuMNUB5RUhyTem7wt8BMGLrDPa6lowox8AMJ-hYVnXdOWy6oyHOc
Message-ID: <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Subject: Re: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org, 
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000084c5b4065241f693"

--00000000000084c5b4065241f693
Content-Type: multipart/alternative; boundary="00000000000084c5b3065241f691"

--00000000000084c5b3065241f691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Thanks for the correction. Updated commit message

On Wed, May 20, 2026 at 3:13=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com>
wrote:

> On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 <capyenglishlite@gmail.com> =
wrote:
> >
> > Hi,
> >
> > You are right, the commit message overstates the impact. The actual
> result is an immediate kernel oops, not an OOB write into adjacent slab
> objects. The fix is still correct - checking the return value avoids the
> oops. Shall I send a v3 with a corrected commit message?
>
> Yes, please send v3.
>
> Sami
>

--00000000000084c5b3065241f691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 Thanks for the correction. Updated commit message=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, May 20, 2026 at 3:13=E2=80=AFPM Sami =
Tolvanen &lt;<a href=3D"mailto:samitolvanen@google.com">samitolvanen@google=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 &lt;<a href=3D"mailto:capy=
englishlite@gmail.com" target=3D"_blank">capyenglishlite@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; You are right, the commit message overstates the impact. The actual re=
sult is an immediate kernel oops, not an OOB write into adjacent slab objec=
ts. The fix is still correct - checking the return value avoids the oops. S=
hall I send a v3 with a corrected commit message?<br>
<br>
Yes, please send v3.<br>
<br>
Sami<br>
</blockquote></div>

--00000000000084c5b3065241f691--
--00000000000084c5b4065241f693
Content-Type: application/octet-stream; 
	name=0003-module-decompress-check-return-value-of-module_extend_max_pages-v3
Content-Disposition: attachment; 
	filename=0003-module-decompress-check-return-value-of-module_extend_max_pages-v3
Content-Transfer-Encoding: base64
Content-ID: <f_mpe94zgz0>
X-Attachment-Id: f_mpe94zgz0

RnJvbSBjNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyaWkgS3VjaG1lbmtvIDxjYXB5ZW5nbGlzaGxpdGVAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDE2IE1heSAyMDI2IDEzOjA4OjAwICswMDAwClN1YmplY3Q6IFtQ
QVRDSCB2M10gbW9kdWxlOiBkZWNvbXByZXNzOiBjaGVjayByZXR1cm4gdmFsdWUgb2YKIG1vZHVs
ZV9leHRlbmRfbWF4X3BhZ2VzKCkKCm1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKCkgY2FsbHMga3Zy
ZWFsbG9jKCkgaW50ZXJuYWxseSBhbmQgcmV0dXJucwotRU5PTUVNIG9uIGFsbG9jYXRpb24gZmFp
bHVyZS4gVGhlIHJldHVybiB2YWx1ZSBpcyBuZXZlciBjaGVja2VkLgoKSWYgdGhlIGFsbG9jYXRp
b24gZmFpbHMsIGluZm8tPnBhZ2VzIGlzIGxlZnQgcG9pbnRpbmcgdG8gZnJlZWQgbWVtb3J5CmFu
ZCBzdWJzZXF1ZW50IGNhbGxzIHRvIG1vZHVsZV9nZXRfbmV4dF9wYWdlKCkgd2lsbCBhdHRlbXB0
IHRvIHdyaXRlCnN0cnVjdCBwYWdlIHBvaW50ZXJzIHRocm91Z2ggdGhlIHN0YWxlIHBvaW50ZXIs
IHJlc3VsdGluZyBpbiBhIGtlcm5lbApvb3BzLgoKRml4OiBhZGQgdGhlIG1pc3NpbmcgZXJyb3Ig
Y2hlY2sgYWZ0ZXIgbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoKSBhbmQKcmV0dXJuIGltbWVkaWF0
ZWx5IG9uIGZhaWx1cmUuIFRoaXMgbWF0Y2hlcyB0aGUgcGF0dGVybiB1c2VkIGJ5IGV2ZXJ5Cm90
aGVyIGt2cmVhbGxvYygpIGNhbGxlciBpbiB0aGUgbW9kdWxlIGxvYWRpbmcgcGF0aC4KCkZpeGVz
OiAxNjlhNThhZDgyNGQgKCJtb2R1bGU6IGFkZCBpbi1rZXJuZWwgc3VwcG9ydCBmb3IgZGVjb21w
cmVzc2luZyIpCkNjOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+
CkNjOiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQW5kcmlpIEt1Y2htZW5rbyA8Y2FweWVuZ2xpc2hs
aXRlQGdtYWlsLmNvbT4KLS0tCkNoYW5nZXMgaW4gdjM6CiAtIENvcnJlY3QgY29tbWl0IG1lc3Nh
Z2U6IGFjdHVhbCBpbXBhY3QgaXMgYSBrZXJuZWwgb29wcywgbm90IGFuCiAgIE9PQiB3cml0ZSBp
bnRvIGFkamFjZW50IHNsYWIgb2JqZWN0cyAoU2FtaSBUb2x2YW5lbikKCkNoYW5nZXMgaW4gdjI6
CiAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBpbml0aWFsaXphdGlvbiBvZiAnZXJyb3InIHRvIDAgKENo
cmlzdG9waGUgTGVyb3kpCiAtIFJlbW92ZSB1bnJlbGF0ZWQgYmxhbmsgbGluZSBhZnRlciBpZiAo
ZXJyb3IpIHJldHVybiBlcnJvciAoQ2hyaXN0b3BoZSBMZXJveSkKCiBrZXJuZWwvbW9kdWxlL2Rl
Y29tcHJlc3MuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEva2VybmVsL21vZHVsZS9kZWNvbXByZXNzLmMgYi9rZXJuZWwvbW9kdWxlL2RlY29t
cHJlc3MuYwotLS0gYS9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYworKysgYi9rZXJuZWwvbW9k
dWxlL2RlY29tcHJlc3MuYwpAQCAtWFhYLDkgK1hYWCwxMiBAQCBpbnQgbW9kdWxlX2RlY29tcHJl
c3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIAkJCQljb25zdCB2b2lkICpidWYsIHNpemVfdCBz
aXplKQogewogCXVuc2lnbmVkIGludCBuX3BhZ2VzOwogCWludCBlcnJvcjsKIAlzc2l6ZV90IGRh
dGFfc2l6ZTsKCiAJbl9wYWdlcyA9IERJVl9ST1VORF9VUChzaXplLCBQQUdFX1NJWkUpICogMjsK
IAllcnJvciA9IG1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKGluZm8sIG5fcGFnZXMpOworCWlmIChl
cnJvcikKKwkJcmV0dXJuIGVycm9yOwogCWRhdGFfc2l6ZSA9IE1PRFVMRV9ERUNPTVBSRVNTX0ZO
KGluZm8sIGJ1Ziwgc2l6ZSk7CiAJaWYgKGRhdGFfc2l6ZSA8IDApIHsKIAkJZXJyb3IgPSBkYXRh
X3NpemU7Ci0tCjIuMzkuMAo=
--00000000000084c5b4065241f693--
