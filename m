Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: LKML <linux-kernel@vger.kernel.org>, Jon Masters <jonathan@jonmasters.org>, linux-modules <linux-modules@vger.kernel.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH 2/2] module: wait when loading a module which is currently initializing.
In-Reply-To: <CAMOw1v6Qy1wHhRcPQkyhDe7LrGaM_qRdhufr8YtHnfp5pTPFAA@mail.gmail.com>
References: <87obl9rsg2.fsf@rustcorp.com.au> <87ligdrscn.fsf@rustcorp.com.au> <CAMOw1v6Qy1wHhRcPQkyhDe7LrGaM_qRdhufr8YtHnfp5pTPFAA@mail.gmail.com>
Date: Mon, 17 Sep 2012 14:06:16 +0930
Message-ID: <878vc9s1tr.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.demarchi@profusion.mobi> writes:
>> -       if (find_module(mod->name)) {
>> +       if ((old = find_module(mod->name)) != NULL) {
>> +               if (old->state == MODULE_STATE_COMING) {
>> +                       /* Wait in case it fails to load. */
>> +                       mutex_unlock(&module_mutex);
>> +                       err = wait_event_interruptible(module_wq,
>> +                                              finished_loading(mod->name));
>> +                       if (err)
>> +                               goto free_arch_cleanup;
>> +                       goto again;
>
> I wonder if we should indeed retry in case the module failed to load
> or if we should just skip straight to returning the error code. We
> don't have the return code for the failed load, but maybe we can
> fabricate one here.
>
> Thoughts?

Could have different cmdline parameters, or other randomness like
out-of-memory.  I think this is safest.

Cheers,
Rusty.
