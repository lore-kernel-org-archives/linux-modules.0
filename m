Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980730DD3A
	for <linux-modules@vger.kernel.org>; Fri, 30 Jan 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772031; cv=none; b=gZSZhB55ja8PreMlbVOrozo1Vb6d//XIJzw/t2dC6FctsBPeE92JtujZTJfT3c6UhoP+ZW6c8pbsLkzluD7ZDYsRVySKzzmf+BM1jErGBh0/pXj+pHsZerBuYifGNqk9/9lLDkqJ/YxigUhxaT8VzuKBNtFFLfysQxANk7zld8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772031; c=relaxed/simple;
	bh=zdaxgBWHfOjQ1zh3GrG3YLN/+zyFU3lbY6MfKIPUukw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwtJv90GlfnCgkNdOYAccASz6lFTILJszUi2DBNIvXIO/QBUaUxBFT2bXuDt88DomSe3ZczEzvEyG7j/LBhHCJsTYZ6Qwo+s6y/wOUMqo1ar5osFRqO4eHFVWfZ/PoJMFr8YpHiIBJHRsC3csLPROeSO+QoYf6jGwpNzfaCmDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRvQ2HJK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOlX2r+l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRvQ2HJK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOlX2r+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769772028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
	b=VRvQ2HJK1IbT7QLP28euYCxozgQ/TwfyAGI3KvyhsHguf8jCGEU5OPnWTCLUJVRfCIm1Pc
	FGXqiRJtZwdToE9iULIZtMBjTVTKbUGPPKpqlSMG8IDmVivavTeprTjhx+mmAf8rPagv5D
	SudMFBSsIr+a5SuhrDbooj7trHC2z4M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-YZZin5odOfi6xKCW7CovRw-1; Fri, 30 Jan 2026 06:20:26 -0500
X-MC-Unique: YZZin5odOfi6xKCW7CovRw-1
X-Mimecast-MFC-AGG-ID: YZZin5odOfi6xKCW7CovRw_1769772026
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a351686c17so17530515ad.0
        for <linux-modules@vger.kernel.org>; Fri, 30 Jan 2026 03:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769772026; x=1770376826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
        b=TOlX2r+l305YUCPNU5nTuFbsbGNAzRCRbdczHGrnIRQzV9y8iMAg8KONhHzFWcE8Zq
         98R2GNKoCLJh6GGlaGC+Az62ptbFqkNhmEZWyKvuuWxl8ko/MJglOVlvtC/uymMR7mB6
         WCSdRZL1iKyEPZPDD05dtKbIFNpDXTx14x3BT1PSKQ5cki9xMropIDIU5ntq1ZamJvxe
         Bk26peZnfPiUeWQq5mm3nKIGByadfO0YVbXp9EOGfu/tpVKsgODKXbVsovoEjXNgWy1t
         pdXBD6PBDUoVnrp0rQb3BBnUrLajJvufZaCqGFZTevEee8UBEscoYllpyflT710lv/fe
         T9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772026; x=1770376826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi7R1t4hPvfEKk8VW4gjKJE0vso+HGJ4y2WhvsIHDuc=;
        b=qG0OE7AkySeLFFojtMa8ICw90Pn6el4SjRFfxwVDWrTikkIVgSY2FJ71j5RreYbX8o
         P3Sn01UlVrjHGbGyVuBRML5BOPql6vonYQcwwl2I+5Nk2X4jfJ1U7mzhNJimLfWT9hkW
         MvXXtGknDpoJTwKK0zfd6QCYqps97R8QHwuvK/RYtGH0JuLf8JrLn98gDSPgAw/rY/U7
         Angc+xpo7q6Pf69J15dgd4gVuiH7cUkh4BHDfmqUJqZRQDSMC3XgrjI6m7y2TaPmR92C
         4DW8iQQKSkfZRt5mvPnzomvbKZ+AXm4nq1dumNd5elj3OczEwlJmIxVm1bRlU94HTAq6
         X2ig==
X-Forwarded-Encrypted: i=1; AJvYcCUwali0cqkBbqTMuIrjf6kLXNBjTrKCIB81jNGCCmC/EnGFepCAusUK0MMSQ3I2Ee1aSe8MPl9oEk3xWfZj@vger.kernel.org
X-Gm-Message-State: AOJu0YygtjbQKJL3bHr9HhJCVE9eoaKFtV7SIdgk8W+EnCqbiq4tsmez
	hExlGTUwkuu8PclaYJHU7MUGNscJuOrY56osvIe3AB8jcaNg8lygZDUN0WwWNlETaKzOq0Dib3M
	Mk9xbXnz9ROqy5OWQ1Zc/tpVGmvs7L1Ud9kEBT6uiIC/c31cl1FB1hYCP+dWxpw7MvNg=
X-Gm-Gg: AZuq6aKDgQaJdGm5X6AmeYh9gBw9I2a5Wltx50Z7BcagKYRfrULLR3F/ep171YGaWFc
	NF4y7wZhXoTtxE7pesefzwzvEYKe6rpW+vf1KZNCaL96gFXBeAH+sQkX/Pn7dGPnq1go4y9/gCP
	gLHa0La0L8hhUnuQ8s9cpSf4mCdQFLLekcwv+4P+D0RdEjRuwN0A4P+uqt1lX2Xasu/LTTn7jRQ
	ZL7Ih4LlSR5DqvJD/ECZdW3CZTyHn+vwFxEMR/N0sCeG+jePpQ0Ou50Ema4bsIhwdmhwS62HDBs
	ST3xEg+i+7KltpefWojtD4yPA/wPM5nGRTYfRcHIFy/9XQe8aercakdf+TE625Ab1IEzdGrYr/D
	x
X-Received: by 2002:a17:903:b0b:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a8d992f0c2mr25748545ad.31.1769772025496;
        Fri, 30 Jan 2026 03:20:25 -0800 (PST)
X-Received: by 2002:a17:903:b0b:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a8d992f0c2mr25748205ad.31.1769772024877;
        Fri, 30 Jan 2026 03:20:24 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm72565075ad.3.2026.01.30.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:20:24 -0800 (PST)
Date: Fri, 30 Jan 2026 19:17:16 +0800
From: Coiby Xu <coxu@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Simo Sorce <simo@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IMA and PQC
Message-ID: <aXrKaTem9nnWNuGV@Rk>
References: <1783975.1769190197@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1783975.1769190197@warthog.procyon.org.uk>

Hi David, 

Thanks for starting the discussion on potential issues or challenges for
IMA PQC support!

On Fri, Jan 23, 2026 at 05:43:17PM +0000, David Howells wrote:
>Hi Mimi,
>
>I've posted patches which I hope will accepted to implement ML-DSA module
>signing:
>
>	https://lore.kernel.org/linux-crypto/1753972.1769166821@warthog.procyon.org.uk/T/#t
>
>but for the moment, it will give an error to pkcs7_get_digest() if there's no
>digest available (which there won't be with ML-DSA).  This means that there
>isn't a hash for IMA to get at for TPM measurement.
>
>Now, I probably have to make a SHA256 hash anyway for UEFI blacklisting
>purposes, so that could be used.  Alternatively, we can require the use of
>authenticatedAttributes/signedAttrs and give you the hash of that - but then
>you're a bit at the mercy of whatever hashes were used.

IMA also uses pkcs7_get_digest mainly for the purpose of checking if the
digest has been blacklisted:) So you making a SHA256 hash for UEFI
blacklisting will automatically resolve this issue.

>
>Further, we need to think how we're going to do PQC support in IMA -
>particularly as the signatures are so much bigger and verification slower.

According to my experiments done so far, for verification speed,
ML-DSA-65 is consistently faster than ECDSA P-384 which is used by
current CentOS/RHEL to sign files in a package. 

The size of a single ML-DSA-65 signature indeed increases dramatically
compared with ECDSA P-384 (3309 bytes vs ~100 bytes). But I'm not sure
it can be a big problem when considering the storage capacity. Take
latest fresh CentOS Stream 10 x86_64 KVM guest as example, without any
file system optimization, extra ~189MB disk space is needed if all files
in /usr signed using by ML-DSA-65 where the disk size is 50G. But I
don't have enough experience to tell how users will perceive it and I'll
try to collect more feedback.

For the details of my experiments, you can check
https://gist.github.com/coiby/41cf3a4d59cd64fb19d35b9ac42e4cd7
And here's the tldr; version,
- Verification Speed: ML-DSA-65 is consistently ~10-12% faster
   at verification than ECDSA P-384 when verifying all files in /usr;
   ML-DSA-65 is 2.5x or 3x faster by "openssl speed"

- Signing Speed: ML-DSA-65 appears ~25-30% slower when signing
   all files in /usr; ML-DSA-65 is 4x or 4.8x slower by "openssl speed"

- Storage overhead: For ML-DSA-65, /usr will increase by 189MB and
   430MB when there are 27346 and 58341 files respectively. But total
   size of pure IMA signatures are estimated (files x (3309+20) bytes) to
   be ~87MB and ~185MB respectively.

>Would ML-DSA-44 be acceptable?  Should we grab some internal state out of
>ML-DSA to use in lieu of a hash?

According to 
https://www.ietf.org/archive/id/draft-salter-lamps-cms-ml-dsa-00.html
ML-DSA-44 is intended to meet NIST's level 2 security category. Will
NIST level 2 meet users' security requirements?

>
>David
>
>

-- 
Best regards,
Coiby

