Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28311494AD
	for <linux-modules@vger.kernel.org>; Wed, 21 Aug 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281494; cv=none; b=HkKrkn4nsq/gYlgQNwqelW/FehgiQ85jYwg/1sCFP6LcSYlXHG/ZmNVCASU8zpvM3PmFMzX+fGCkwCP0tlYhWtnyP4eFb/LGf/shwo572MyoFH/BHm3+1if3TviAoGZzDOGI6yIcL16ywSnynwR7HVXa+xkuxfARn504PIKT4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281494; c=relaxed/simple;
	bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnvGJo9VSmpqVLYyPWwCZi8zWYude3GqrvG+P7iNHUGpQvyh0gQkFOGet4jCWU98BHp/osv9/FphqgQ5chz80hFrEdFfLdoU3KORx5kUr3Sdsm0Bav3w3E1sUe7CkyGaP2X5FjoRKN1AFRxwfH6yTwzrW/UZgIeg44UTrlaJC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jk9GE3Sn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk9GE3Sn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-454b1e08393so137031cf.0
        for <linux-modules@vger.kernel.org>; Wed, 21 Aug 2024 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724281491; x=1724886291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
        b=jk9GE3SnFF5uMUbbFuvAzam/GdH28zfOKokTeiwMZPBVnc7nnBEYaYjBTCP3N8I2r8
         by863YUezMjaAsoUie/jrNsQWFsHU96ECQlfoBRTKCXhpLCuROtKdQKQKHnXZQjNMenc
         90bUb6DfnFDeLrxp1GfadT0Vnb6Ve/FO7arS2IauhLt56eEDjpnFc3j6lnKM71IorKgm
         IwsmKKwMJfFx3Ki7m/hXz3yY0pqedsIduxGkTYEnX5N4Hq80sTOGL7u9yQBOG8dXiPAJ
         Zxw5hlCLIqPkJcWTzglJi4TnBqkWO+gjV/yFkR3mdQSvlSbPxtb50gLJqhtPO7gpHv9f
         cAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281491; x=1724886291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJDNSAt1cuq2r8IoJd4PodaJixWuh12VF9JsHEBLnWU=;
        b=YFnufcfKBZeKJRrNFZ4EWWQAXik9P1uGW77JFu5X6CbgT80avgPtS+W0conmwf1pJv
         cGyhcUYYKGySKidewSNMSCqvRTDsvV6ILtE9r2P227qHbcSJDCe0JlcGn+5Z+xa/OIvy
         s24t7WNIevlYW39wpVexf0oTO41LqLJQJ5kp/6UUmM+Mim91UTjQmPin6088ZwyWR0J7
         ORc/iZqolkiGhjxjGQHF8OO3nDy3xvMEdXTQmPpgB88ueFD8Mi3wVetPzzzLbk0ae9QC
         JsLdWfFh+6jdsUyjxXPfXyFCiTUvpMkvYpuiTCFmuNGU4iYv2k8kiAos5iyaoFVkCjYm
         PeCg==
X-Gm-Message-State: AOJu0YwVWJ97rK+OtAF4c/j4M9SQdyz/jtI4NrVMsJMqTlI1YEXitR1t
	a5VYjVaMDHqZICSAzF3jQc0/t0nOyKh5OMPo+mHJ7O2gQUgteHFG2fI20cQ1DvqW+uiDUADNQ9O
	NfzaAZZr8a3K+ucdMDXdsTpEnXpgxeLw5PzwVH51lTLt60MVDZsJ+
X-Google-Smtp-Source: AGHT+IHmPa8pxLjrhVQLkC0yK2VEkXUspddO+C6x2tTzxUsPkltMol2I8t/oFwFehRGi9Lm7bXiwfHkQ11nVaIA64J4=
X-Received: by 2002:a05:622a:4cd:b0:44f:9e0f:bc41 with SMTP id
 d75a77b69052e-454fd7a0bc8mr539491cf.27.1724281490717; Wed, 21 Aug 2024
 16:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821174021.2371547-1-mcgrof@kernel.org>
In-Reply-To: <20240821174021.2371547-1-mcgrof@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 21 Aug 2024 16:04:14 -0700
Message-ID: <CABCJKudNN=-4oXm8XboaKrMJ3U6ZF6kAUgDBwqEk+89Rc0EtVQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: scale modules with more reviewers
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	petr.pavlu@suse.com, da.gomez@samsung.com, kris.van.hees@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:40=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> We're looking to add Rust module support, and I don't speak
> Rust yet. The compromise was reached that in order to scale we'd
> get volunteers committed from the Rust community willing to review
> both Rust and C code for modules so we can ensure we get proper
> reviews for both parts of the code and so that we can scale.
>
> Add those who have stepped up to help.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Sami Tolvanen <samitolvanen@google.com>

Sami
