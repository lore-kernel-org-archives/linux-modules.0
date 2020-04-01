Return-Path: <SRS0=Kpxa=5R=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81476C43331
	for <linux-modules@archiver.kernel.org>; Wed,  1 Apr 2020 21:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEDD20772
	for <linux-modules@archiver.kernel.org>; Wed,  1 Apr 2020 21:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgWU7I13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbgDAVXD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:23:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54111 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVXD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 1 Apr 2020 17:23:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id d77so1279808wmd.3
        for <linux-modules@vger.kernel.org>; Wed, 01 Apr 2020 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=2zzLWXdpfOIS+Gm0CyRwUQB1dpscFF97orsW709AfXQ=;
        b=pgWU7I13VYFpWy0hU5EGJUAlnhosUXGehPoDUyaJWZMaOW1mqyWWF1fpBDDabFk/yt
         vrgilr7iAPfDHGhGsW54CCkemBIRbmcQKsPM4aKOKYlpYKsr/gCN8SGXWq8xYRtRAM/w
         6zhizQdZoh1ZUHr6Hkzoqpa/10yEu+ytopKJk8qJltjWhqaEQGkClCt3YEAyKvFANQL/
         nXh3osoz2wYCM7fuUtyGuy055ry0kFHpltFSZNDtPGZMy0Filh5GtIxn2L4LQrP0We60
         IzOnDukKntplYa6ObXS36gvE1KYYOFLjD4sVql5U7z9TdeThn0Pm7O688T6t5B+rVoCH
         d8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=2zzLWXdpfOIS+Gm0CyRwUQB1dpscFF97orsW709AfXQ=;
        b=gLRNTAbqqj1zAFzoVSv6YFvWznaDyYrzFPnfYdReArFxaSPRYoaqcyKbyr+MB7VXYi
         gYXuiXRlAPF7TPNXtcMx8FSnp4imGc73rraInqS/QTM0EQCQANZQCCNhUjccBsS7shR/
         rJPDQnX0A+2jXdcn1DqZ4Q1rnvte+S0fep3kfl7x96y9vcLWqGG3uMwhLeunVVDHpMKB
         2U36nlXfYtbSHXyZ6mrl1MsDDrSPllhdvlOcSKo11F4TO5oDDe1N9iy0NhGfAnXkHlFU
         WjPlia6w9W7tpxcRFnhpfFzMoInJr6PH/n7oM9mChjEvTFcc5gIanq3SMqGIhTuxKonm
         uykw==
X-Gm-Message-State: AGi0PuZHjMMzeoOVNFDSyoeqE8dviNYLxAB4qHEofYZGIDWN52vz6sEO
        suMrK7Y9ttdCWpu3DuumjxJ2QOiW
X-Google-Smtp-Source: APiQypJv3KYtF33Q7hLcsuJkQC1FDZfuV6QAhPOJlP+e/lhPELEvDPuZ/9txhQwQ6iVBsLVdMQB1+g==
X-Received: by 2002:a1c:82:: with SMTP id 124mr317531wma.63.1585776179283;
        Wed, 01 Apr 2020 14:22:59 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:6000:3878:c820:d9e6:1e25? (p200300EA8F2960003878C820D9E61E25.dip0.t-ipconnect.de. [2003:ea:8f29:6000:3878:c820:d9e6:1e25])
        by smtp.googlemail.com with ESMTPSA id y4sm4320067wrl.40.2020.04.01.14.22.58
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 14:22:58 -0700 (PDT)
Subject: Fwd: RFC: Handle hard module dependencies that are not symbol-based
 (r8169 + realtek)
References: <f8e3f271-82df-165f-63f1-6df73ba3d59c@gmail.com>
To:     linux-modules@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
X-Forwarded-Message-Id: <f8e3f271-82df-165f-63f1-6df73ba3d59c@gmail.com>
Message-ID: <92546e9f-db6e-ccc0-147d-f3692984d620@gmail.com>
Date:   Wed, 1 Apr 2020 23:22:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f8e3f271-82df-165f-63f1-6df73ba3d59c@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------E686288C426E950A13F06616"
Content-Language: en-US
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is a multi-part message in MIME format.
--------------E686288C426E950A13F06616
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Mistakenly sent it to linux-module instead of linux-modules.

-------- Forwarded Message --------
Subject: RFC: Handle hard module dependencies that are not symbol-based (r8169 + realtek)
Date: Wed, 1 Apr 2020 23:20:20 +0200
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Jessica Yu <jeyu@kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-module@vger.kernel.org, netdev@vger.kernel.org <netdev@vger.kernel.org>

Currently we have no way to express a hard dependency that is not
a symbol-based dependency (symbol defined in module A is used in
module B). Use case:
Network driver ND uses callbacks in the dedicated PHY driver DP
for the integrated PHY (namely read_page() and write_page() in
struct phy_driver). If DP can't be loaded (e.g. because ND is in
initramfs but DP is not), then phylib will use the generic
PHY driver GP. GP doesn't implement certain callbacks that are
needed by ND, therefore ND's probe has to bail out with an error
once it detects that DP is not loaded.
We have this problem with driver r8169 having such a dependency
on PHY driver realtek. Some distributions have tools for
configuring initramfs that consider hard dependencies based on
depmod output. Means so far somebody can add r8169.ko to initramfs,
and neither human being nor machine will have an idea that
realtek.ko needs to be added too.

Attached patch set (two patches for kmod, one for the kernel)
allows to express this hard dependency of ND from DP. depmod will
read this dependency information and treat it like a symbol-based
dependency. As a result tools e.g. populating initramfs can
consider the dependency and place DP in initramfs if ND is in
initramfs. On my system the patch set does the trick when
adding following line to r8169_main.c:
MODULE_HARDDEP("realtek");

I'm interested in your opinion on the patches, and whether you
maybe have a better idea how to solve the problem.

Heiner


--------------E686288C426E950A13F06616
Content-Type: text/plain; charset=UTF-8;
 name="0001-depmod-add-helper-mod_add_dep_unique.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-depmod-add-helper-mod_add_dep_unique.patch"

RnJvbSAyOTBlN2RlZTlmNjA0M2Q2NzdmMDhkYzA2ZTYxMmUxM2VlMGQyZDgzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDMxIE1hciAyMDIwIDIzOjAyOjQ3ICswMjAwClN1YmplY3Q6
IFtQQVRDSCAxLzJdIGRlcG1vZDogYWRkIGhlbHBlciBtb2RfYWRkX2RlcF91bmlxdWUKCkNy
ZWF0ZSBuZXcgaGVscGVyIG1vZF9hZGRfZGVwX3VuaXF1ZSgpLCBuZXh0IHBhdGNoIGluIHRo
aXMgc2VyaWVzIHdpbGwKYWxzbyBtYWtlIHVzZSBvZiBpdC4KClNpZ25lZC1vZmYtYnk6IEhl
aW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+Ci0tLQogdG9vbHMvZGVwbW9k
LmMgfCAyNiArKysrKysrKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdG9vbHMvZGVw
bW9kLmMgYi90b29scy9kZXBtb2QuYwppbmRleCA4NzVlMzE0Li41NDE5ZDRkIDEwMDY0NAot
LS0gYS90b29scy9kZXBtb2QuYworKysgYi90b29scy9kZXBtb2QuYwpAQCAtOTA3LDIzICs5
MDcsMzUgQEAgc3RhdGljIHZvaWQgbW9kX2ZyZWUoc3RydWN0IG1vZCAqbW9kKQogCWZyZWUo
bW9kKTsKIH0KIAotc3RhdGljIGludCBtb2RfYWRkX2RlcGVuZGVuY3koc3RydWN0IG1vZCAq
bW9kLCBzdHJ1Y3Qgc3ltYm9sICpzeW0pCitzdGF0aWMgaW50IG1vZF9hZGRfZGVwX3VuaXF1
ZShzdHJ1Y3QgbW9kICptb2QsIHN0cnVjdCBtb2QgKmRlcCkKIHsKIAlpbnQgZXJyOwogCi0J
REJHKCIlcyBkZXBlbmRzIG9uICVzICVzXG4iLCBtb2QtPnBhdGgsIHN5bS0+bmFtZSwKLQkg
ICAgc3ltLT5vd25lciAhPSBOVUxMID8gc3ltLT5vd25lci0+cGF0aCA6ICIodW5rbm93biki
KTsKLQotCWlmIChzeW0tPm93bmVyID09IE5VTEwpCisJaWYgKGRlcCA9PSBOVUxMKQogCQly
ZXR1cm4gMDsKIAotCWVyciA9IGFycmF5X2FwcGVuZF91bmlxdWUoJm1vZC0+ZGVwcywgc3lt
LT5vd25lcik7CisJZXJyID0gYXJyYXlfYXBwZW5kX3VuaXF1ZSgmbW9kLT5kZXBzLCBkZXAp
OwogCWlmIChlcnIgPT0gLUVFWElTVCkKIAkJcmV0dXJuIDA7CiAJaWYgKGVyciA8IDApCiAJ
CXJldHVybiBlcnI7CiAKLQlzeW0tPm93bmVyLT51c2VycysrOworCWRlcC0+dXNlcnMrKzsK
KworCXJldHVybiAxOworfQorCitzdGF0aWMgaW50IG1vZF9hZGRfZGVwZW5kZW5jeShzdHJ1
Y3QgbW9kICptb2QsIHN0cnVjdCBzeW1ib2wgKnN5bSkKK3sKKwlpbnQgZXJyOworCisJREJH
KCIlcyBkZXBlbmRzIG9uICVzICVzXG4iLCBtb2QtPnBhdGgsIHN5bS0+bmFtZSwKKwkgICAg
c3ltLT5vd25lciAhPSBOVUxMID8gc3ltLT5vd25lci0+cGF0aCA6ICIodW5rbm93bikiKTsK
KworCWVyciA9IG1vZF9hZGRfZGVwX3VuaXF1ZShtb2QsIHN5bS0+b3duZXIpOworCWlmIChl
cnIgPD0gMCkKKwkJcmV0dXJuIGVycjsKKwogCVNIT1coIiVzIG5lZWRzIFwiJXNcIjogJXNc
biIsIG1vZC0+cGF0aCwgc3ltLT5uYW1lLCBzeW0tPm93bmVyLT5wYXRoKTsKIAlyZXR1cm4g
MDsKIH0KLS0gCjIuMjYuMAoK
--------------E686288C426E950A13F06616
Content-Type: text/plain; charset=UTF-8;
 name="0001-module-add-MODULE_HARDDEP.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-module-add-MODULE_HARDDEP.patch"

RnJvbSBiMTJmYTBkODViMjFkODRjZGY0NTA5YzUwNDhjNjdlMTc5MTRlYjI4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDMwIE1hciAyMDIwIDE3OjEyOjQ0ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gbW9kdWxlOiBhZGQgTU9EVUxFX0hBUkRERVAKCkN1cnJlbnRseSB3ZSBoYXZl
IG5vIHdheSB0byBleHByZXNzIGEgaGFyZCBkZXBlbmRlbmN5IHRoYXQgaXMgbm90IGEKc3lt
Ym9sLWJhc2VkIGRlcGVuZGVuY3kgKHN5bWJvbCBkZWZpbmVkIGluIG1vZHVsZSBBIGlzIHVz
ZWQgaW4KbW9kdWxlIEIpLiBVc2UgY2FzZToKTmV0d29yayBkcml2ZXIgTkQgdXNlcyBjYWxs
YmFja3MgaW4gdGhlIGRlZGljYXRlZCBQSFkgZHJpdmVyIERQCmZvciB0aGUgaW50ZWdyYXRl
ZCBQSFkuIElmIERQIGNhbid0IGJlIGxvYWRlZCAoZS5nLiBiZWNhdXNlIE5ECmlzIGluIGlu
aXRyYW1mcyBidXQgRFAgaXMgbm90KSwgdGhlbiBwaHlsaWIgd2lsbCBsb2FkIHRoZSBnZW5l
cmljClBIWSBkcml2ZXIgR1AuIEdQIGRvZXNuJ3QgaW1wbGVtZW50IGNlcnRhaW4gY2FsbGJh
Y2tzIHRoYXQgYXJlCnVzZWQgYnkgTkQsIHRoZXJlZm9yZSBORCdzIHByb2JlIGhhcyB0byBi
YWlsIG91dCB3aXRoIGFuIGVycm9yCm9uY2UgaXQgZGV0ZWN0cyB0aGF0IERQIGlzIG5vdCBs
b2FkZWQuClRoaXMgcGF0Y2ggYWxsb3dzIHRvIGV4cHJlc3MgdGhpcyBoYXJkIGRlcGVuZGVu
Y3kgb2YgTkQgZnJvbSBEUC4KZGVwbW9kIHdpbGwgcmVhZCB0aGlzIGRlcGVuZGVuY3kgaW5m
b3JtYXRpb24gYW5kIHRyZWF0IGl0IGxpa2UKYSBzeW1ib2wtYmFzZWQgZGVwZW5kZW5jeS4g
QXMgYSByZXN1bHQgdG9vbHMgZS5nLiBwb3B1bGF0aW5nCmluaXRyYW1mcyBjYW4gY29uc2lk
ZXIgdGhlIGRlcGVuZGVuY3kgYW5kIHBsYWNlIERQIGluIGluaXRyYW1mcwppZiBORCBpcyBp
biBpbml0cmFtZnMuCgpTaWduZWQtb2ZmLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2Vp
dDFAZ21haWwuY29tPgotLS0KIGluY2x1ZGUvbGludXgvbW9kdWxlLmggfCA1ICsrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tb2R1bGUuaCBiL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKaW5kZXggMWFkMzkzZTYy
Li5mMzhkNDEwN2YgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW9kdWxlLmgKKysrIGIv
aW5jbHVkZS9saW51eC9tb2R1bGUuaApAQCAtMTY5LDYgKzE2OSwxMSBAQCBleHRlcm4gdm9p
ZCBjbGVhbnVwX21vZHVsZSh2b2lkKTsKICAqLwogI2RlZmluZSBNT0RVTEVfU09GVERFUChf
c29mdGRlcCkgTU9EVUxFX0lORk8oc29mdGRlcCwgX3NvZnRkZXApCiAKKy8qIEhhcmQgbW9k
dWxlIGRlcGVuZGVuY2llcyB0aGF0IGFyZSBub3QgY29kZSBkZXBlbmRlbmNpZXMKKyAqIEV4
YW1wbGU6IE1PRFVMRV9IQVJEREVQKCJtb2R1bGUtZm9vIG1vZHVsZS1iYXIiKQorICovCisj
ZGVmaW5lIE1PRFVMRV9IQVJEREVQKF9oYXJkZGVwKSBNT0RVTEVfSU5GTyhoYXJkZGVwLCBf
aGFyZGRlcCkKKwogLyoKICAqIE1PRFVMRV9GSUxFIGlzIHVzZWQgZm9yIGdlbmVyYXRpbmcg
bW9kdWxlcy5idWlsdGluCiAgKiBTbywgbWFrZSBpdCBuby1vcCB3aGVuIHRoaXMgaXMgYmVp
bmcgYnVpbHQgYXMgYSBtb2R1bGUKLS0gCjIuMjYuMAoK
--------------E686288C426E950A13F06616
Content-Type: text/plain; charset=UTF-8;
 name="0002-depmod-add-depmod_load_harddeps.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-depmod-add-depmod_load_harddeps.patch"

RnJvbSBhZjNhMjU4MzNhMTYwZTAyOTQ0MWVhZjVhOTNmN2M4NjI1NTQ0Mjk2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDEgQXByIDIwMjAgMjI6NDI6NTUgKzAyMDAKU3ViamVjdDog
W1BBVENIIDIvMl0gZGVwbW9kOiBhZGQgZGVwbW9kX2xvYWRfaGFyZGRlcHMKCkxvYWQgZXhw
bGljaXRseSBkZWNsYXJlZCBoYXJkIGRlcGVuZGVuY3kgaW5mb3JtYXRpb24gZnJvbSBtb2R1
bGVzIGFuZAphZGQgaXQgdG8gdGhlIHN5bWJvbC1kZXJpdmVkIGRlcGVuZGVuY2llcy4gVGhp
cyB3aWxsIGFsbG93CmRlcG1vZC1iYXNlZCB0b29scyB0byBjb25zaWRlciBoYXJkIGRlcGVu
ZGVuY2llcyB0aGF0IGFyZSBub3QgY29kZQpkZXBlbmRlbmNpZXMuCgpTaWduZWQtb2ZmLWJ5
OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPgotLS0KIHRvb2xzL2Rl
cG1vZC5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvZGVw
bW9kLmMgYi90b29scy9kZXBtb2QuYwppbmRleCA1NDE5ZDRkLi41NzcxZGM5IDEwMDY0NAot
LS0gYS90b29scy9kZXBtb2QuYworKysgYi90b29scy9kZXBtb2QuYwpAQCAtMTUyMiw2ICsx
NTIyLDQxIEBAIHN0YXRpYyBzdHJ1Y3Qgc3ltYm9sICpkZXBtb2Rfc3ltYm9sX2ZpbmQoY29u
c3Qgc3RydWN0IGRlcG1vZCAqZGVwbW9kLAogCXJldHVybiBoYXNoX2ZpbmQoZGVwbW9kLT5z
eW1ib2xzLCBuYW1lKTsKIH0KIAorc3RhdGljIHZvaWQgZGVwbW9kX2xvYWRfaGFyZGRlcHMo
c3RydWN0IGRlcG1vZCAqZGVwbW9kLCBzdHJ1Y3QgbW9kICptb2QpCit7CisKKwlzdHJ1Y3Qg
a21vZF9saXN0ICpsOworCisJa21vZF9saXN0X2ZvcmVhY2gobCwgbW9kLT5pbmZvX2xpc3Qp
IHsKKwkJY29uc3QgY2hhciAqa2V5ID0ga21vZF9tb2R1bGVfaW5mb19nZXRfa2V5KGwpOwor
CQljb25zdCBjaGFyICpkZXBfbmFtZTsKKwkJc3RydWN0IG1vZCAqZGVwOworCQljaGFyICp2
YWx1ZTsKKworCQlpZiAoIXN0cmVxKGtleSwgImhhcmRkZXAiKSkKKwkJCWNvbnRpbnVlOwor
CisJCXZhbHVlID0gc3RyZHVwKGttb2RfbW9kdWxlX2luZm9fZ2V0X3ZhbHVlKGwpKTsKKwkJ
aWYgKHZhbHVlID09IE5VTEwpCisJCQlyZXR1cm47CisKKwkJZGVwX25hbWUgPSBzdHJ0b2so
dmFsdWUsICIgXHQiKTsKKworCQl3aGlsZSAoZGVwX25hbWUpIHsKKwkJCWRlcCA9IGhhc2hf
ZmluZChkZXBtb2QtPm1vZHVsZXNfYnlfbmFtZSwgZGVwX25hbWUpOworCQkJaWYgKGRlcCkK
KwkJCQltb2RfYWRkX2RlcF91bmlxdWUobW9kLCBkZXApOworCQkJZWxzZQorCQkJCVdSTigi
aGFyZGRlcDogJXM6IHVua25vd24gZGVwZW5kZW5jeSAlc1xuIiwKKwkJCQkgICAgbW9kLT5t
b2RuYW1lLCBkZXBfbmFtZSk7CisKKwkJCWRlcF9uYW1lID0gc3RydG9rKE5VTEwsICIgXHQi
KTsKKwkJfQorCisJCWZyZWUodmFsdWUpOworCX0KK30KKwogc3RhdGljIGludCBkZXBtb2Rf
bG9hZF9tb2R1bGVzKHN0cnVjdCBkZXBtb2QgKmRlcG1vZCkKIHsKIAlzdHJ1Y3QgbW9kICoq
aXRyLCAqKml0cl9lbmQ7CkBAIC0xNTY5LDYgKzE2MDQsOSBAQCBzdGF0aWMgaW50IGRlcG1v
ZF9sb2FkX21vZHVsZV9kZXBlbmRlbmNpZXMoc3RydWN0IGRlcG1vZCAqZGVwbW9kLCBzdHJ1
Y3QgbW9kICptbwogCXN0cnVjdCBrbW9kX2xpc3QgKmw7CiAKIAlEQkcoImRvIGRlcGVuZGVu
Y2llcyBvZiAlc1xuIiwgbW9kLT5wYXRoKTsKKworCWRlcG1vZF9sb2FkX2hhcmRkZXBzKGRl
cG1vZCwgbW9kKTsKKwogCWttb2RfbGlzdF9mb3JlYWNoKGwsIG1vZC0+ZGVwX3N5bV9saXN0
KSB7CiAJCWNvbnN0IGNoYXIgKm5hbWUgPSBrbW9kX21vZHVsZV9kZXBlbmRlbmN5X3N5bWJv
bF9nZXRfc3ltYm9sKGwpOwogCQl1aW50NjRfdCBjcmMgPSBrbW9kX21vZHVsZV9kZXBlbmRl
bmN5X3N5bWJvbF9nZXRfY3JjKGwpOwotLSAKMi4yNi4wCgo=
--------------E686288C426E950A13F06616--
