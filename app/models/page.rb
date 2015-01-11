#!/bin/env ruby
# encoding: utf-8
class Page < ActiveRecord::Base

  has_ancestry

  VALID_NAME_REGEX = /\A[a-zA-Zа-яА-Я0-9_]*\z/i
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, length: { maximum: 50, minimum: 1 }
  validates :title, presence:  true, length: { maximum: 50, minimum: 1 }

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :slug, uniqueness: true, presence: true

  def normalize_friendly_id(value)
    name_as_slug = Russian.translit(value).parameterize
    return if name_as_slug == slug.split('/').last  if !slug.blank?
    slug_elements = []
    slug_elements << parent.slug if parent.present?
    slug_elements << name_as_slug
    self.slug = slug_elements.join('/')
  end
end
